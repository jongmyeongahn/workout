//
//  CustomActionSheetViewController.swift
//  300Sec
//
//  Created by arthur on 9/8/24.
//
import UIKit

class CustomActionSheetViewController: UIViewController {

    private let containerView = UIView()
    
    private let stacView: UIStackView = {
        let stacView = UIStackView()
        stacView.axis = .vertical
        stacView.translatesAutoresizingMaskIntoConstraints = false
        stacView.clipsToBounds = true
        stacView.layer.cornerRadius = 10
        stacView.spacing = 0
        return stacView
    }()
    
    private let separator: UIView = {
        let separtator = UIView()
        separtator.backgroundColor = .gray
        separtator.translatesAutoresizingMaskIntoConstraints = false
        return separtator
    }()
    
    private let editButton = UIButton(type: .system)
    private let deleteButton = UIButton(type: .system)
    private let cancelButton = UIButton(type: .system)

    var onEdit: (() -> Void)?
    var onDelete: (() -> Void)?
    var onCancel: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        // 배경 터치 제스처 인식기 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        view.addGestureRecognizer(tapGesture)
        
        setupContainerView()
        setupButtonGroupView()
        setupButtons()
    }

    private func setupContainerView() {
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        
        // Container view 제약 조건 설정
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            containerView.heightAnchor.constraint(equalToConstant: 160) // 적절한 높이 설정
        ])
    }

    private func setupButtonGroupView() {
 
        containerView.addSubview(stacView)
        containerView.addSubview(cancelButton)
        stacView.addArrangedSubview(editButton)
        stacView.addArrangedSubview(separator)
        stacView.addArrangedSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            stacView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stacView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            stacView.topAnchor.constraint(equalTo: containerView.topAnchor),
            stacView.heightAnchor.constraint(equalToConstant: 100),
            
            editButton.heightAnchor.constraint(equalToConstant: 50),
            
            separator.heightAnchor.constraint(equalToConstant: 0.5),

            deleteButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }

    private func setupButtons() {

        editButton.setTitle("Edit RM", for: .normal)
        editButton.backgroundColor = UIColor.darkGray
        editButton.titleLabel?.font = .systemFont(ofSize: 20)
        editButton.setTitleColor(.white, for: .normal)
//        editButton.layer.cornerRadius = 10
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)

        deleteButton.setTitle("Remove RM", for: .normal)
        deleteButton.backgroundColor = UIColor.darkGray
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.titleLabel?.font = .systemFont(ofSize: 20)
//        deleteButton.layer.cornerRadius = 10
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)

        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.layer.cornerRadius = 10
        cancelButton.titleLabel?.font = .systemFont(ofSize: 20)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        cancelButton.backgroundColor = UIColor.darkGray
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            cancelButton.topAnchor.constraint(equalTo: stacView.bottomAnchor, constant: 10),
            cancelButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func editButtonTapped() {
        onEdit?()
        dismiss(animated: true, completion: nil)
    }

    @objc private func deleteButtonTapped() {
        onDelete?()
        dismiss(animated: true, completion: nil)
    }

    @objc private func cancelButtonTapped() {
        onCancel?()
        dismiss(animated: true, completion: nil)
    }
    
    // 배경을 터치했을 때 호출되는 메서드
    @objc private func backgroundTapped(_ sender: UITapGestureRecognizer) {
        // 배경 터치 시 액션 시트 닫기
        dismiss(animated: true, completion: nil)
    }
}
