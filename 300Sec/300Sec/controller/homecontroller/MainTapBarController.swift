//
//  MainTapBarController.swift
//  300Sec
//
//  Created by arthur on 9/5/24.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        configureTabBarAppearance()
        configureController()
        self.delegate = self
        
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // 현재 선택된 탭 인덱스를 UserDefaults에 저장
        let selectedIndex = tabBarController.selectedIndex
        UserDefaults.standard.set(selectedIndex, forKey: "lastSelectedTabIndex")
    }
    
    func configureController() {
        view.backgroundColor = .clear
        tabBar.backgroundColor =  #colorLiteral(red: 0.05130089074, green: 0.05285990983, blue: 0.06366523355, alpha: 1)
        
        // 이미지 언랩핑
        let todayImage = UIImage(systemName: "list.bullet") ?? UIImage()
        let todaySelectedImage = UIImage(systemName: "list.bullet.indent") ?? UIImage()
        
//        let addAlarmImage = UIImage(systemName: "plus.circle") ?? UIImage()
//        let addAlarmSelectedImage = UIImage(systemName: "plus.circle.fill") ?? UIImage()
//        
        let everyDayImage = UIImage(systemName: "list.bullet") ?? UIImage()
        let everyDaySelectedImage = UIImage(systemName: "list.bullet.indent") ?? UIImage()
        //여기서 등록하는거아님 사실상 씬델리게이트나 앱델리게이트에서 변경하곤함
        //보통 거기서 등록하고 배열로 확인하고 관리함
        let todayWod = createNavController(
            viewController: FirstViewController(),
            title: "WOD",
            image: todayImage,
            selectedImage: todaySelectedImage
        )
        let record = createNavController(
            viewController: ProfileViewController(),
            title: "Profile",
            image: everyDayImage,
            selectedImage: everyDaySelectedImage
        )
        
        viewControllers = [todayWod, record]
    }
    
    private func createNavController(viewController: UIViewController, title: String, image: UIImage, selectedImage: UIImage) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = selectedImage
        navController.navigationBar.tintColor = .systemBlue
        
        return navController
    }
    
    private func configureTabBarAppearance() {
        // 기본 탭바 배경 색상 설정
        tabBar.barTintColor = #colorLiteral(red: 0.05130089074, green: 0.05285990983, blue: 0.06366523355, alpha: 1) // 탭바의 배경색
        
        // 선택된 아이템 색상
        tabBar.tintColor = .white
        
        // 비활성화된 아이템 색상
        tabBar.unselectedItemTintColor = .gray
        
        // 탭바 아이템의 폰트 설정
        let appearance = UITabBarItem.appearance()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14)
        ]
        appearance.setTitleTextAttributes(attributes, for: .normal)
    }
}
