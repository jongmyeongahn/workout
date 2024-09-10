//
//  SplashViewController.swift
//  300Sec
//
//  Created by arthur on 9/5/24.
//

import UIKit

class SplashViewController: UIViewController {
    
    let textLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        let mainTitle = "300s\n"
        let subTitle = "workout"

        // 줄 간격 설정
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0 // 줄 간격을 0으로 설정하여 위아래 공백을 최소화

        // 첫 번째 텍스트 (메인 타이틀)
        let mainTitleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 50, weight: .bold),
            .foregroundColor: UIColor.white,
            .paragraphStyle: paragraphStyle // 줄 간격 설정
        ]
        let mainTitleAttributedString = NSAttributedString(string: mainTitle, attributes: mainTitleAttributes)

        // 두 번째 텍스트 (서브타이틀)
        let subtitleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 35),
            .foregroundColor: UIColor.white,
            .paragraphStyle: paragraphStyle // 줄 간격 설정
        ]
        let subtitleAttributedString = NSAttributedString(string: subTitle, attributes: subtitleAttributes)

        // 두 텍스트 사이의 공백 조정
        let attributedString = NSMutableAttributedString()
        attributedString.append(mainTitleAttributedString)
        attributedString.append(subtitleAttributedString)

        subtitleLabel.attributedText = attributedString
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center

        return subtitleLabel
    }()

    let logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "workout1")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        performAnimations()

    }
    
    private func setUpUI() {
        view.backgroundColor = .black
        
        view.addSubview(textLabel)
        view.addSubview(logoImageView)
        
        // A.splash UI
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // 텍스트 레이블의 제약 조건 설정
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // 로고 이미지 뷰의 제약 조건 설정 (초기에는 숨김)
        logoImageView.isHidden = true
        
//        // A.2초 뒤에 메인 로그인 페이지로 이동 / UI 비동기 처리
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            self.showMainScreen()
//        }
    }
    private func performAnimations() {
        // 랜덤 이미지 설정
        let randomImages = [
            UIImage(named: "main1"),
            UIImage(named: "main2"),
            UIImage(named: "main3"),
            UIImage(named: "main4"),
            UIImage(named: "main5"),
            UIImage(named: "main6"),
            UIImage(named: "main7"),
            UIImage(named: "main8"),
            UIImage(named: "main9"),
            UIImage(named: "main10"),
        ]
        
        let randomImage = randomImages.randomElement() ?? UIImage()
        logoImageView.image = randomImage
        
        // textLabel을 뷰의 최상단으로 가져옵니다.
        self.view.bringSubviewToFront(self.textLabel)

        // 2초 동안 검정색 배경 유지
        self.view.backgroundColor = .black
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // 배경색이 회색으로 변하는 애니메이션
            UIView.animate(withDuration: 0.1, animations: {
                self.view.backgroundColor = .lightGray
            }) { _ in
                // 텍스트 애니메이션
                UIView.animate(withDuration: 1.0, animations: {
                    let scaleTransform = CGAffineTransform(scaleX: 0.7, y: 0.7) // 텍스트 크기를 줄입니다
                    let translateTransform = CGAffineTransform(translationX: 0, y: -200) // 텍스트를 위로 이동합니다
                    self.textLabel.transform = scaleTransform.concatenating(translateTransform)
                }) { _ in
                    // 애니메이션 완료 후 배경색이 사라지면서 이미지가 보이도록
                    UIView.transition(with: self.view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                        self.view.backgroundColor = .clear
//                        self.textLabel.textColor = .white
                    }) { _ in
                        // 1초 후에 메인 화면으로 이동
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.showMainScreen()
                        }
                    }
                }
                
                // 이미지 뷰 표시 및 애니메이션
                self.logoImageView.isHidden = false
                self.logoImageView.alpha = 0
                UIView.transition(with: self.logoImageView, duration: 1.0, options: .transitionCrossDissolve, animations: {
                    self.logoImageView.alpha = 1
                })
            }
        }
    }

    // 모달창 메인 페이지로 이동
    private func showMainScreen() {
        let loginVC = MainTabBarController()
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
    }

}
