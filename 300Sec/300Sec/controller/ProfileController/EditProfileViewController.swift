//
//  EditProfileViewController.swift
//  300Sec
//
//  Created by arthur on 9/9/24.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    private let editView = EditProfileView()
    
    override func loadView() {
        super.loadView()
        view = editView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBarTitle()

        // Do any additional setup after loading the view.
    }
    
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

}
