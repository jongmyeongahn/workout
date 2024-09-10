//
//  TopTapBarView.swift
//  300Sec
//
//  Created by arthur on 9/4/24.
//

import UIKit
import SnapKit

protocol TopTabBarViewDelegate: AnyObject {
    func didSelectTab(at index: Int)
}

class TopTabBarView: UIView {
    
    private var collectionView: UICollectionView!
    private var indicatorView: UIView!
    private var tabs: [String] = []
    weak var delegate: TopTabBarViewDelegate?
    
    
    var targetIndex: Int = 0 {
        didSet {
            moveIndicatorbar(to: targetIndex)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        //        setupIndicatorView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with tabs: [String]) {
        self.tabs = tabs
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0 // 페이지 간 간격을 없앱니다
        layout.sectionInset = .zero // 섹션 인셋을 없앱니다
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true // 페이징을 활성화합니다
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TopTabBarCollectionViewCell.self, forCellWithReuseIdentifier: "TopTabBarCollectionViewCell")
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func moveIndicatorbar(to index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        
        // 레이아웃을 강제로 업데이트
        collectionView.layoutIfNeeded()
        
        // UICollectionViewCell의 레이아웃이 완료된 후에 위치를 업데이트
        DispatchQueue.main.async {
            if self.collectionView.cellForItem(at: indexPath) is TopTabBarCollectionViewCell {
//                //                let cellWidth = cell.titleLabel.frame.width
//                //                let cellCenterX = cell.center.x
//                _ = cell.contentView.convert(cell.contentView.bounds, to: self)
                
                UIView.animate(withDuration: 0.3) {
                    self.layoutIfNeeded()
                }
            }
        }
        
        // 모든 셀을 초기화 상태로 설정
        for cell in collectionView.visibleCells {
            if let topTabCell = cell as? TopTabBarCollectionViewCell {
                topTabCell.configure(isSelected: false)
            }
        }
        
        // 선택된 셀을 활성화 상태로 설정
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? TopTabBarCollectionViewCell {
            selectedCell.configure(isSelected: true)
        }
    }
}

extension TopTabBarView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopTabBarCollectionViewCell", for: indexPath) as! TopTabBarCollectionViewCell
        cell.titleLabel.text = tabs[indexPath.item]
        
        cell.configure(isSelected: indexPath.item == targetIndex)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectTab(at: indexPath.item)
        
        // 모든 셀을 비활성화 상태로 설정
        for cell in collectionView.visibleCells {
            if let topTabCell = cell as? TopTabBarCollectionViewCell {
                topTabCell.configure(isSelected: false)
            }
        }
        
        // 선택된 셀을 활성화 상태로 설정
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? TopTabBarCollectionViewCell {
            selectedCell.configure(isSelected: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title = tabs[indexPath.item]
        let width = title.size(withAttributes: [.font: UIFont.systemFont(ofSize: 16)]).width
        return CGSize(width: width + 20, height: 50)
    }
}

