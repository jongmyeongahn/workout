//
//  RMView.swift
//  300Sec
//
//  Created by arthur on 9/7/24.
//

import UIKit

class RMView: UIView {
    
    let weightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter weight"
        textField.textColor = .white
        textField.backgroundColor = #colorLiteral(red: 0.01360723097, green: 0.01638710871, blue: 0.01815891452, alpha: 1)
        textField.borderStyle = .roundedRect
        
        // 플레이스홀더 색상 및 폰트 설정
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray, // 플레이스홀더 색상
            .font: UIFont.boldSystemFont(ofSize: 18) // 굵은 폰트
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Enter weight", attributes: placeholderAttributes)
        
        // 텍스트 필드의 폰트 설정
        textField.font = UIFont.boldSystemFont(ofSize: 18)
        
        // 텍스트 중앙 정렬
        textField.textAlignment = .center
        
        return textField
    }()

    let exerciseTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter exercise"
        textField.textColor = .white
        textField.backgroundColor = #colorLiteral(red: 0.01360723097, green: 0.01638710871, blue: 0.01815891452, alpha: 1)
        textField.borderStyle = .roundedRect
        
        // 플레이스홀더 색상 및 폰트 설정
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray, // 플레이스홀더 색상
            .font: UIFont.boldSystemFont(ofSize: 18) // 굵은 폰트
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Enter exercise", attributes: placeholderAttributes)
        
        // 텍스트 필드의 폰트 설정
        textField.font = UIFont.boldSystemFont(ofSize: 18)
        
        // 텍스트 중앙 정렬
        textField.textAlignment = .center
        
        return textField
    }()

    override init(frame: CGRect) {
        super .init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    private func setupViews() {
        addSubview(weightTextField)
        addSubview(exerciseTextField)
        
        weightTextField.translatesAutoresizingMaskIntoConstraints = false
        exerciseTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weightTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            weightTextField.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            weightTextField.widthAnchor.constraint(equalToConstant: 150),
            
            exerciseTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            exerciseTextField.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 10),
            exerciseTextField.widthAnchor.constraint(equalToConstant: 150),
            
        ])
    }
    
}
