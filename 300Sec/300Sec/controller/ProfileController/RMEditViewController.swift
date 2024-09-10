//
//  RMViewController.swift
//  300Sec
//
//  Created by arthur on 9/7/24.
//

import UIKit

protocol RMEditDelegate: AnyObject {
    func didUpdateRMItem(_ updatedRMItem: RMItem, at index: Int, isEditingMode: Bool)
    func didDeleteRMItem(at index: Int)
}

class RMEditViewController: UIViewController {
    
    weak var delegate: RMEditDelegate?
    private var rmItem: RMItem
    private var index: Int
    private var isEditingMode: Bool // 수정 모드인지 확인하는 플래그
    
    private var rmView = RMView()
    
    init(rmItem: RMItem, index: Int, isEditingMode: Bool = false) { // isEditingMode 추가
        self.rmItem = rmItem
        self.index = index
        self.isEditingMode = isEditingMode // 초기화
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = rmView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
//        navigationBarCustome()
        navigationBarCustom()
        
        rmView.weightTextField.text = rmItem.weight
        rmView.exerciseTextField.text = rmItem.exercise
        
        rmView.weightTextField.delegate = self
        rmView.exerciseTextField.delegate = self

    }
    // 네비게이션 바 커스텀
     private func navigationBarCustom() {
         
         let actionButton = UIButton(type: .system)
         let buttonTitle = isEditingMode ? "Done" : "Add" // 수정 모드에 따라 버튼 타이틀 변경
         actionButton.setTitle(buttonTitle, for: .normal)
         actionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
         actionButton.setTitleColor(.white, for: .normal)
         actionButton.setTitleColor(.gray, for: .highlighted)
         actionButton.sizeToFit()
         
         actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
         
         let barButtonItem = UIBarButtonItem(customView: actionButton)
         navigationItem.rightBarButtonItem = barButtonItem
         
         let backButtonImage = UIImage(named: "back")?.withRenderingMode(.alwaysTemplate)
         let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(cancelButtonTapped))
         backButton.tintColor = .white
         self.navigationItem.leftBarButtonItem = backButton
         self.navigationItem.backButtonTitle = ""
         
         // 타이틀 설정
         let titleLabel = UILabel()
         titleLabel.text = isEditingMode ? "Edit RM" : "Add RM" // 수정 모드에 따라 타이틀 변경
         titleLabel.textColor = .white
         titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
         titleLabel.sizeToFit()
         self.navigationItem.titleView = titleLabel
     }
    
    @objc func actionButtonTapped() {
        let updatedRMItem = RMItem(weight: rmView.weightTextField.text ?? "", exercise: rmView.exerciseTextField.text ?? "")
        delegate?.didUpdateRMItem(updatedRMItem, at: index, isEditingMode: isEditingMode)
        dismiss(animated: true, completion: nil)
    }

    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rmView.weightTextField.becomeFirstResponder() // 텍스트 필드 자동 선택
    }
    
}

extension RMEditViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == rmView.weightTextField {
            rmView.exerciseTextField.becomeFirstResponder()
        } else if textField == rmView.exerciseTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}

