//
//  KG:LGCALView.swift
//  300Sec
//
//  Created by arthur on 9/8/24.
//

import UIKit

class KgLbCalView: UIView {
    
    let stackView: UIStackView = {
        let stacView = UIStackView()
        stacView.axis = .horizontal
        stacView.spacing = 10
        stacView.alignment = .center
        stacView.distribution = .fillEqually
        stacView.translatesAutoresizingMaskIntoConstraints = false
        return stacView
    }()
    
    let calLabel: UILabel = {
        let calLabel = UILabel()
        calLabel.font = .boldSystemFont(ofSize: 40)
        calLabel.textColor = .white
        calLabel.textAlignment = .right
        calLabel.text = "0"
        calLabel.translatesAutoresizingMaskIntoConstraints = false
        return calLabel
    }()
    
    let unitLabel: UILabel = {
        let unitLabel = UILabel()
        unitLabel.font = .boldSystemFont(ofSize: 30)
        unitLabel.textColor = .white
        unitLabel.text = "lb"
        unitLabel.translatesAutoresizingMaskIntoConstraints = false
        return unitLabel
    }()
    
    let unitStackView: UIStackView = {
        let unitStackView = UIStackView()
        unitStackView.axis = .horizontal
        unitStackView.distribution = .fillEqually
        unitStackView.alignment = .center
        unitStackView.spacing = 10
        unitStackView.backgroundColor = .clear
        unitStackView.translatesAutoresizingMaskIntoConstraints = false
        return unitStackView
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.placeholder = "Enter weight"
        textField.keyboardType = .numberPad
        textField.textColor = .white
        textField.backgroundColor = #colorLiteral(red: 0.01360723097, green: 0.01638710871, blue: 0.01815891452, alpha: 1)
        textField.borderStyle = .roundedRect
        
        // 플레이스홀더 색상 및 폰트 설정
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray, // 플레이스홀더 색상
            .font: UIFont.boldSystemFont(ofSize: 20) // 굵은 폰트
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Enter weight", attributes: placeholderAttributes)
        
        // 텍스트 필드의 폰트 설정
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        
        // 텍스트 중앙 정렬
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let kgunitInputButton: UIButton = {
        let kgunitInputButton = UIButton()
        kgunitInputButton.setTitle("KG", for: .normal)
        kgunitInputButton.titleLabel?.font = .systemFont(ofSize: 20)
        kgunitInputButton.tintColor = .white
        kgunitInputButton.backgroundColor = .green
        kgunitInputButton.clipsToBounds = true
        kgunitInputButton.layer.cornerRadius = 10
        kgunitInputButton.setTitleColor(.white, for: .normal)
        kgunitInputButton.translatesAutoresizingMaskIntoConstraints = false
        return kgunitInputButton
    }()
    
    let lbunitInputButton: UIButton = {
        let lbunitInputButton = UIButton()
        lbunitInputButton.setTitle("LB", for: .normal)
        lbunitInputButton.titleLabel?.font = .systemFont(ofSize: 20)
        lbunitInputButton.setTitleColor(.white, for: .normal)
        lbunitInputButton.backgroundColor = .darkGray
        lbunitInputButton.clipsToBounds = true
        lbunitInputButton.layer.cornerRadius = 10
        lbunitInputButton.translatesAutoresizingMaskIntoConstraints = false
        return lbunitInputButton
    }()
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(calLabel)
        stackView.addArrangedSubview(unitLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 150),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 200),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            calLabel.heightAnchor.constraint(equalToConstant: 40),
            calLabel.widthAnchor.constraint(equalToConstant: 150),
            
            unitLabel.heightAnchor.constraint(equalToConstant: 40),
        
        ])
        
        addSubview(inputTextField)
        
        NSLayoutConstraint.activate([
            inputTextField.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            inputTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            inputTextField.heightAnchor.constraint(equalToConstant: 40),
            inputTextField.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        addSubview(unitStackView)
        unitStackView.addArrangedSubview(kgunitInputButton)
        unitStackView.addArrangedSubview(lbunitInputButton)
        
        NSLayoutConstraint.activate([
            
            unitStackView.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 20),
            unitStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            unitStackView.widthAnchor.constraint(equalToConstant: 120),
            unitStackView.heightAnchor.constraint(equalToConstant: 50),
            
            kgunitInputButton.heightAnchor.constraint(equalToConstant: 40),
            
            lbunitInputButton.heightAnchor.constraint(equalToConstant: 40),
        
        ])
        

    }
    
}
