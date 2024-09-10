//
//  PercentViewController.swift
//  300Sec
//
//  Created by arthur on 9/8/24.
//

import UIKit

class PercentViewController: UIViewController {
    
    let percentView = PercentView()
    
    override func loadView() {
        super.loadView()
        view = percentView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        configureNavigationBarTitle()
        setUpActions()
        
        // 초기 세팅을 파운드 단위로 설정
        isKgSelected = false
        updateButtonStates()
        updateLabelAndCalculation()
        
        addToolbarOnTextFields()
    }
    
    
    private var isKgSelected = false
    
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
        titleLabel.text = "Pecent Calculation"
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
        percentView.inputTextField.becomeFirstResponder()
    }
    
    private func setUpActions() {
        percentView.kgunitInputButton.addTarget(self, action: #selector(kgButtonTapped), for: .touchUpInside)
        percentView.lbunitInputButton.addTarget(self, action: #selector(lbButtonTapped), for: .touchUpInside)
        percentView.inputTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        percentView.percentTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
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
        percentView.kgunitInputButton.backgroundColor = isKgSelected ? .green : .darkGray
        percentView.lbunitInputButton.backgroundColor = isKgSelected ? .darkGray : .green
        percentView.unitLabel.text = isKgSelected ? "kg" : "lb"
    }
    
    @objc private func textFieldDidChange() {
        updateLabelAndCalculation()
    }
    
    private func updateLabelAndCalculation() {
        guard let weightText = percentView.inputTextField.text, let weight = Double(weightText),
              let percentText = percentView.percentTextField.text, let percent = Double(percentText) else {
            percentView.calLabel.text = "0"
            return
        }
        
        let result: Double
        if isKgSelected {
            result = weight * (percent / 100) // 1RM * 퍼센트 값
        } else {
            result = weight * (percent / 100) // lb 변환 후 계산
        }
        
        percentView.calLabel.text = String(format: "%.0f", result)
    }
    
    // Next와 Done 버튼을 각 텍스트 필드에 추가
    private func addToolbarOnTextFields() {
        // 첫 번째 텍스트 필드용 툴바 생성 (Cancel + Next 버튼)
        let toolbarForInput = UIToolbar()
        toolbarForInput.sizeToFit()
        let cancelButtonForInput = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonAction))
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonAction))
        let flexibleSpace = UIBarButtonItem.flexibleSpace()
        toolbarForInput.setItems([cancelButtonForInput, flexibleSpace, nextButton], animated: false)
        toolbarForInput.isUserInteractionEnabled = true
        percentView.inputTextField.inputAccessoryView = toolbarForInput
        
        // 두 번째 텍스트 필드용 툴바 생성 (Cancel + Done 버튼)
        let toolbarForPercent = UIToolbar()
        toolbarForPercent.sizeToFit()
        let cancelButtonForPercent = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonAction))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        toolbarForPercent.setItems([cancelButtonForPercent, flexibleSpace, doneButton], animated: false)
        toolbarForPercent.isUserInteractionEnabled = true
        percentView.percentTextField.inputAccessoryView = toolbarForPercent
    }

    @objc private func cancelButtonAction() {
        // 현재 포커스된 텍스트 필드에서 포커스를 제거하여 키보드를 내리기
        view.endEditing(true)
    }

    @objc private func nextButtonAction() {
        percentView.percentTextField.becomeFirstResponder()
    }

    @objc private func doneButtonAction() {
        percentView.percentTextField.resignFirstResponder() // 키보드 내리기
    }

    
}
