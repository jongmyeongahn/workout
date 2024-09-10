//
//  EditProfileView.swift
//  300Sec
//
//  Created by arthur on 9/9/24.
//

import UIKit

class EditProfileView: UIView {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var NameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .boldSystemFont(ofSize: 20)
        nameLabel.textColor = .white
        nameLabel.text = "Name"
        return nameLabel
    }()
    
    private let nameTextField: UITextField = {
        let nametextField = UITextField()
        nametextField.translatesAutoresizingMaskIntoConstraints = false
        nametextField.borderStyle = .roundedRect
        nametextField.placeholder = "Name"
        return nametextField
    }()
    
    var goalLabel: UILabel = {
        let goalNameLabel = UILabel()
        goalNameLabel.translatesAutoresizingMaskIntoConstraints = false
        goalNameLabel.font = .boldSystemFont(ofSize: 20)
        goalNameLabel.textColor = .white
        goalNameLabel.text = "goal"
        return goalNameLabel
    }()
    
    private let goalTextField: UITextField = {
        let goaltextField = UITextField()
        goaltextField.translatesAutoresizingMaskIntoConstraints = false
        goaltextField.borderStyle = .roundedRect
        goaltextField.placeholder = "Your workout goal"
        return goaltextField
    }()
    
    var memoLabel: UILabel = {
        let memoLabel = UILabel()
        memoLabel.translatesAutoresizingMaskIntoConstraints = false
        memoLabel.font = .boldSystemFont(ofSize: 20)
        memoLabel.textColor = .white
        memoLabel.text = "Note"
        return memoLabel
    }()
    
    private let memoTextField: UITextField = {
        let memotextField = UITextField()
        memotextField.translatesAutoresizingMaskIntoConstraints = false
        memotextField.borderStyle = .roundedRect
        memotextField.placeholder = "Your workout notes"
        return memotextField
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
          addSubview(profileImageView)
          addSubview(nameTextField)
          addSubview(memoTextField)
 
          // 레이아웃 설정
          NSLayoutConstraint.activate([
              profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
              profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
              profileImageView.widthAnchor.constraint(equalToConstant: 100),
              profileImageView.heightAnchor.constraint(equalToConstant: 100),
              
              nameTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
              nameTextField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
              nameTextField.widthAnchor.constraint(equalToConstant: 200),
              
              memoTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
              memoTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
              memoTextField.widthAnchor.constraint(equalToConstant: 200),
              
          ])
      }
}
