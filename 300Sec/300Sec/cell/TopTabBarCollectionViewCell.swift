//
//  TabCell.swift
//  300Sec
//
//  Created by arthur on 9/4/24.
//

import UIKit

class TopTabBarCollectionViewCell: UICollectionViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var underline: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.alpha = 0.0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.addSubview(underline)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        underline.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            underline.heightAnchor.constraint(equalToConstant: 3.0),
            underline.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.0),
            underline.leadingAnchor.constraint(equalTo: leadingAnchor),
            underline.trailingAnchor.constraint(equalTo: trailingAnchor),
            underline.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(isSelected: Bool) {
        titleLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: 20) : UIFont.systemFont(ofSize: 18)
        titleLabel.textColor = isSelected ? .systemBlue : .white
        underline.alpha = isSelected ? 1.0 : 0.0

    }
}
