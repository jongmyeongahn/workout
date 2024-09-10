//
//  PostCell.swift
//  300Sec
//
//  Created by arthur on 9/6/24.
//

import UIKit


class RMCollectionViewCell: UICollectionViewCell {
    
    private let weightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let exerciseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(weightLabel)
        contentView.addSubview(exerciseLabel)
        
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        exerciseLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // 셀의 중앙에 위치시키기 위한 제약 조건
            weightLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weightLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10),
            
            exerciseLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            exerciseLabel.topAnchor.constraint(equalTo: weightLabel.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with rmItem: RMItem) {
        weightLabel.text = rmItem.weight
        exerciseLabel.text = rmItem.exercise
        
    }
}
