//
//  KGLBCalViewController.swift
//  300Sec
//
//  Created by arthur on 9/8/24.
//

import UIKit

class KgLbCalViewController: UIViewController {
    
    let kgLBCalView = KgLbCalView()
    
    override func loadView() {
        super.loadView()
        view = kgLBCalView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        configureNavigationBarTitle()
        setUpActions()
        
    }
    
    private var isKgSelected = true
    
    // 네비게이션 바 커스텀 설정
    private func configureNavigationBarTitle() {
        
        let actionButton = UIButton(type: .system)
        let buttonTitle = "Done"
        actionButton.setTitle(buttonTitle, for: .normal)
        actionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.setTitleColor(.gray, for: .highlighted)
        actionButton.sizeToFit()
        
        actionButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: actionButton)
        navigationItem.rightBarButtonItem = barButtonItem
        
        let backButtonImage = UIImage(named: "back")?.withRenderingMode(.alwaysTemplate)
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(cancelButtonTapped))
        backButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.backButtonTitle = ""
        
        // 타이틀 텍스트 설정
        let titleLabel = UILabel()
        titleLabel.text = "KG/LB Calcuration"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        titleLabel.sizeToFit()
        
        // 네비게이션 바에 커스텀 타이틀 설정
        self.navigationItem.titleView = titleLabel
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        kgLBCalView.inputTextField.becomeFirstResponder() // 텍스트 필드 자동 선택
    }
    
    private func setUpActions() {
        kgLBCalView.kgunitInputButton.addTarget(self, action: #selector(kgButtonTapped), for: .touchUpInside)
        kgLBCalView.lbunitInputButton.addTarget(self, action: #selector(lbButtonTapped), for: .touchUpInside)
        kgLBCalView.inputTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc private func kgButtonTapped() {
        isKgSelected = true
        updateButtonStates()
        updateLabelAndCalculation()
    }
    
    @objc private func lbButtonTapped() {
        isKgSelected = false
        updateButtonStates()
        updateLabelAndCalculation()
    }
    
    private func updateButtonStates() {
        kgLBCalView.kgunitInputButton.backgroundColor = isKgSelected ? .green : .darkGray
        kgLBCalView.lbunitInputButton.backgroundColor = isKgSelected ? .darkGray : .green
        kgLBCalView.unitLabel.text = isKgSelected ? "lb" : "kg"
    }
    
    @objc private func textFieldDidChange() {
        updateLabelAndCalculation()
    }
    
    private func updateLabelAndCalculation() {
        guard let text = kgLBCalView.inputTextField.text, let value = Double(text) else {
            kgLBCalView.calLabel.text = "0"
            return
        }
        
        let result: Double
        if isKgSelected {
            result = value * 2.20462 // Convert kg to lb
        } else {
            result = value * 0.453592 // Convert lb to kg
        }
        
        kgLBCalView.calLabel.text = String(format: "%.0f", result)
    }
    
}
