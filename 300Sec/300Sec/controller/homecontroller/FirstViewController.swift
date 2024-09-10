//
//  FirstViewController.swift
//  300Sec
//
//  Created by arthur on 8/23/24.
//

import UIKit
import MessageUI
import SnapKit

class FirstViewController: UIViewController {
    let firstView = FirstView()
    var pageViewController: UIPageViewController!
    private var topTabBarView: TopTabBarView!
    // 스크롤뷰 감지를 위한 변수
    private var isPageScrolling: Bool = false
    var controllers: [UIViewController] = []
    var currentPageIndex: Int = 0 {
        didSet {
            updatePageViewController()
        }
    }
    
    override func loadView() {
        super.loadView()
        view = firstView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  .black
        
        // 네비게이션 바 설정
        configureNavigationBar()
        
        // 네비게이션 바 타이틀 설정
        configureNavigationBarTitle()
        
        setupTopTabBarView()
        
        setupPageViewController()
        
        pageViewController.delegate = self
        
    }
    
    private func configureNavigationBar() {
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.barTintColor = .black // 네비게이션 바 배경색을 검정으로 설정
            navigationBar.isTranslucent = false
            navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
            ]
        }
        
        // 달력 아이콘 버튼 추가
        let calendarButton = UIBarButtonItem(
            image: UIImage(systemName: "calendar"),
            style: .plain,
            target: self,
            action: #selector(showCalendar)
        )
        calendarButton.tintColor = .systemBlue
        navigationItem.rightBarButtonItem = calendarButton
    }
    
    @objc private func showCalendar() {
        // CalendarViewController를 모달로 표시
        let calendarViewController = CalendarViewController()
        calendarViewController.modalPresentationStyle = .pageSheet
        present(calendarViewController, animated: true, completion: nil)
    }
    
    // 네비게이션 바 커스텀 설정
    private func configureNavigationBarTitle() {
        // 현재 날짜를 사용자의 로케일에 맞춰 포맷팅
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long // 사용자의 로케일에 맞는 긴 날짜 형식
        dateFormatter.timeStyle = .none // 시간은 표시하지 않음
        dateFormatter.locale = Locale.current // 사용자의 현재 로케일을 사용
        
        let currentDate = dateFormatter.string(from: Date())
        
        // 타이틀 텍스트 설정
        let titleLabel = UILabel()
        titleLabel.text = currentDate
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        titleLabel.sizeToFit()
        
        // 네비게이션 바에 커스텀 타이틀 설정
        self.navigationItem.titleView = titleLabel
    }
    
    private func setupPageViewController() {
        guard let topTabBarView = topTabBarView else { return }
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        
        // Example view controllers
        let firstVC = PersonalViewController()
        let secondVC = AMRAPViewController()
        let thirdVC = ForTimeViewController()
        let fourVC = EMOMViewController()
        let fiveVC = adsViewController()
        let sixVC = GroupViewController()
        
        controllers = [firstVC, secondVC, thirdVC, fourVC, fiveVC, sixVC ]
        pageViewController.setViewControllers([firstVC], direction: .forward, animated: false)
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(topTabBarView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setupTopTabBarView() {
        topTabBarView = TopTabBarView()
        topTabBarView.delegate = self
        topTabBarView.configure(with: ["300s", "AMRAP", "For Time", "EMOM", "ads", "Group"])
        
        view.addSubview(topTabBarView)
        topTabBarView.snp.makeConstraints { make in
            make.top.equalTo(firstView.weeklyCalendarView).offset(70)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
    }
    
    private func updatePageViewController() {
        guard currentPageIndex >= 0 && currentPageIndex < controllers.count else { return }
        let direction: UIPageViewController.NavigationDirection = currentPageIndex < topTabBarView.targetIndex ? .forward : .reverse
        pageViewController.setViewControllers([controllers[currentPageIndex]], direction: direction, animated: true)
    }
    
}


extension FirstViewController: TopTabBarViewDelegate {
    func didSelectTab(at index: Int) {
        currentPageIndex = index
    }
}

extension FirstViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController) else { return nil }
        return index > 0 ? controllers[index - 1] : nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController) else { return nil }
        return index < controllers.count - 1 ? controllers[index + 1] : nil
    }
}

extension FirstViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let targetVC = pendingViewControllers.first,
              let targetIndex = controllers.firstIndex(of: targetVC) else { return }
        topTabBarView.targetIndex = targetIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentIndex = controllers.firstIndex(of: currentVC) else { return }
        
        if completed {
            topTabBarView.targetIndex = currentIndex
        }
    }
}
