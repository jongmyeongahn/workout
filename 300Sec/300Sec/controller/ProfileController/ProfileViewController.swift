//
//  RecordViewController.swift
//  300Sec
//
//  Created by arthur on 9/5/24.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    private var rmItems: [RMItem] = [] // RM 항목 데이터 배열
    
    private let profileView = ProfileView()
    
    override func loadView() {
        super.loadView()
        view = profileView
        
        setupGestureRecognizers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileView.collectionView.delegate = self
        profileView.collectionView.dataSource = self
        profileView.collectionView.register(RMCollectionViewCell.self, forCellWithReuseIdentifier: "RMCell")
        
        profileView.kgLbCalButton.addTarget(self, action: #selector(kglbButtonTapped), for: .touchUpInside)
        
        profileView.percentCalButton.addTarget(self, action: #selector(percentButtonTapped), for: .touchUpInside)
        
        profileView.addRMButton.addTarget(self, action: #selector(addRMButtonTapped), for: .touchUpInside)
        
        // RM 항목 데이터 로드 또는 설정
        rmItems = loadRMItems()
    }
    
    @objc private func addRMButtonTapped() {
        // 새로운 RMItem을 배열의 시작 부분에 추가
        let newRMItem = RMItem(weight: "", exercise: "")
        rmItems.insert(newRMItem, at: 0) // 맨 처음에 추가

        // 컬렉션 뷰의 새 항목을 반영하도록 갱신
        profileView.collectionView.performBatchUpdates({
            let indexPath = IndexPath(item: 0, section: 0) // 첫 번째 항목의 인덱스
            profileView.collectionView.insertItems(at: [indexPath])
        }, completion: nil)
        
        // 편집 화면을 표시
        let rmEditVC = RMEditViewController(rmItem: newRMItem, index: 0)
        rmEditVC.delegate = self
        let navigationController = UINavigationController(rootViewController: rmEditVC)
        navigationController.modalPresentationStyle = .formSheet // 원하는 모달 스타일로 설정
        present(navigationController, animated: true, completion: nil)
    }

    
    @objc private func kglbButtonTapped() {
        let kglbVC = KgLbCalViewController()
        let navigationController = UINavigationController(rootViewController: kglbVC)
        navigationController.modalPresentationStyle = .fullScreen // or .overCurrentContext for full screen
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc private func percentButtonTapped() {
        let percentVC = PercentViewController()
        let navigationController = UINavigationController(rootViewController: percentVC)
        navigationController.modalPresentationStyle = .fullScreen // or .overCurrentContext for full screen
        present(navigationController, animated: true, completion: nil)
    }
    
    // 각 라벨에 터치 제스처 추가
    private func setupGestureRecognizers() {
        let rm1TapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapRMLabel(_:)))
        profileView.RM1Label.isUserInteractionEnabled = true
        profileView.RM1Label.addGestureRecognizer(rm1TapGesture)
        
        let rm1UnderTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapRMLabel(_:)))
        profileView.RM1underLabel.isUserInteractionEnabled = true
        profileView.RM1underLabel.addGestureRecognizer(rm1UnderTapGesture)
        
        let rm2TapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapRMLabel(_:)))
        profileView.RM2Label.isUserInteractionEnabled = true
        profileView.RM2Label.addGestureRecognizer(rm2TapGesture)
        
        let rm2UnderTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapRMLabel(_:)))
        profileView.RM2underLabel.isUserInteractionEnabled = true
        profileView.RM2underLabel.addGestureRecognizer(rm2UnderTapGesture)
        
        let rm3TapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapRMLabel(_:)))
        profileView.RM3Label.isUserInteractionEnabled = true
        profileView.RM3Label.addGestureRecognizer(rm3TapGesture)
        
        let rm3UnderTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapRMLabel(_:)))
        profileView.RM3underLabel.isUserInteractionEnabled = true
        profileView.RM3underLabel.addGestureRecognizer(rm3UnderTapGesture)
    }

    @objc private func didTapRMLabel(_ sender: UITapGestureRecognizer) {
        guard let label = sender.view as? UILabel else { return }
        
        let rmItem: RMItem
        let index: Int
        
        // 각 라벨의 텍스트를 기반으로 RMItem을 생성
        switch label {
        case profileView.RM1Label, profileView.RM1underLabel:
            rmItem = RMItem(weight: profileView.RM1Label.text ?? "", exercise: profileView.RM1underLabel.text ?? "")
            index = 0
        case profileView.RM2Label, profileView.RM2underLabel:
            rmItem = RMItem(weight: profileView.RM2Label.text ?? "", exercise: profileView.RM2underLabel.text ?? "")
            index = 1
        case profileView.RM3Label, profileView.RM3underLabel:
            rmItem = RMItem(weight: profileView.RM3Label.text ?? "", exercise: profileView.RM3underLabel.text ?? "")
            index = 2
        default:
            return
        }
        
        let rmEditVC = RMEditViewController(rmItem: rmItem, index: index, isEditingMode: true)
        rmEditVC.delegate = self
        let navigationController = UINavigationController(rootViewController: rmEditVC)
        present(navigationController, animated: true, completion: nil)
    }

}

extension ProfileViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    // 컬렉션 뷰 데이터 소스
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rmItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RMCell", for: indexPath) as! RMCollectionViewCell
        let rmItem = rmItems[indexPath.item]
        cell.configure(with: rmItem)
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout 구현
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = rmItems[indexPath.item]
        
        // 텍스트 길이에 따라 셀의 폭을 조정
        let textWidth = item.weight.width(withConstrainedHeight: 40, font: UIFont.systemFont(ofSize: 17)) // weight의 길이에 따라 폭 조정
        let exerciseWidth = item.exercise.width(withConstrainedHeight: 40, font: UIFont.systemFont(ofSize: 17)) // exercise의 길이에 따라 폭 조정
        let maxWidth = max(textWidth, exerciseWidth) // 최대 길이에 맞춰서 폭 결정
        
        return CGSize(width: maxWidth + 20, height: 90) // 텍스트 길이 + 여백
    }
    
    // 셀이 선택되었을 때 모달창을 통해 수정/삭제할 수 있도록 설정
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showCustomActionSheet(for: indexPath)
    }
    
    private func showCustomActionSheet(for indexPath: IndexPath) {
        // CustomActionSheetViewController가 이미 표시되고 있는지 확인
        if presentedViewController is CustomActionSheetViewController {
            return
        }
        
        let customActionSheetVC = CustomActionSheetViewController()
        customActionSheetVC.modalPresentationStyle = .overFullScreen
        customActionSheetVC.modalTransitionStyle = .crossDissolve
        customActionSheetVC.onEdit = { [weak self] in
            self?.editCell(at: indexPath)

        }
        customActionSheetVC.onDelete = { [weak self] in
            self?.deleteCell(at: indexPath)
        }
        customActionSheetVC.onCancel = {
            // Handle cancel action
        }
        
        present(customActionSheetVC, animated: true, completion: nil)
    }
    
    @objc private func editCell(at indexPath: IndexPath) {
        // CustomActionSheetViewController가 닫히고 난 후에만 모달을 표시
        if presentedViewController is CustomActionSheetViewController {
            presentedViewController?.dismiss(animated: true) { [weak self] in
                let rmItem = self?.rmItems[indexPath.item]
                let rmEditVC = RMEditViewController(rmItem: rmItem ?? RMItem(weight: "", exercise: ""), index: indexPath.item, isEditingMode: false)
                rmEditVC.delegate = self
                
                let navigationController = UINavigationController(rootViewController: rmEditVC)
                navigationController.modalPresentationStyle = .fullScreen // fullScreen으로 설정
                self?.present(navigationController, animated: true, completion: nil)
            }
        } else {
            let rmItem = rmItems[indexPath.item]
            let rmEditVC = RMEditViewController(rmItem: rmItem, index: indexPath.item, isEditingMode: false)
            rmEditVC.delegate = self
            
            let navigationController = UINavigationController(rootViewController: rmEditVC)
            navigationController.modalPresentationStyle = .fullScreen // fullScreen으로 설정
            present(navigationController, animated: true, completion: nil)
        }
    }
    

    private func deleteCell(at indexPath: IndexPath) {
        rmItems.remove(at: indexPath.item)
        profileView.collectionView.reloadData()
    }
    
    private func loadRMItems() -> [RMItem] {
        // RM 항목 데이터 로드 또는 생성
        return []
    }
}


extension ProfileViewController: RMEditDelegate {
    func didUpdateRMItem(_ updatedRMItem: RMItem, at index: Int, isEditingMode: Bool) {
        if isEditingMode {
             // 라벨만 업데이트
             switch index {
             case 0:
                 profileView.RM1Label.text = updatedRMItem.weight
                 profileView.RM1underLabel.text = updatedRMItem.exercise
             case 1:
                 profileView.RM2Label.text = updatedRMItem.weight
                 profileView.RM2underLabel.text = updatedRMItem.exercise
             case 2:
                 profileView.RM3Label.text = updatedRMItem.weight
                 profileView.RM3underLabel.text = updatedRMItem.exercise
             default:
                 break
             }
         } else {
             // rmItems 배열 업데이트
             if index < rmItems.count {
                 rmItems[index] = updatedRMItem
             } else {
                 rmItems.append(updatedRMItem)
             }
             profileView.collectionView.reloadData()
         }
                
    }
    
    func didDeleteRMItem(at index: Int) {
        if index < rmItems.count {
            rmItems.remove(at: index)
            profileView.collectionView.reloadData()
        }
    }
}

extension String {
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}


