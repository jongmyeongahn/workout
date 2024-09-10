//
//  CalendarViewController.swift
//  300Sec
//
//  Created by arthur on 9/3/24.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {

    private let calendar = FSCalendar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setupCalendar()
        configureModalPresentation()
    }

    private func setupCalendar() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        calendar.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(calendar)
        
        calendar.backgroundColor = .black
        calendar.appearance.headerTitleColor = .white
        calendar.appearance.weekdayTextColor = .white
        calendar.appearance.titleDefaultColor = .white
        calendar.appearance.titleTodayColor = .red
        calendar.appearance.titleWeekendColor = .lightGray
        
        // Customize today’s circle
        calendar.appearance.todayColor = UIColor.red // Background color for today's date
        calendar.appearance.todaySelectionColor = UIColor.red // Selection color for today's date
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 16) // Default title font size
        
        // Set calendar delegate
        calendar.delegate = self
        calendar.dataSource = self
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: scrollView.topAnchor),
            calendar.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            calendar.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            calendar.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            calendar.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // Set content size to accommodate multiple months
        let calendarHeight: CGFloat = 800 // Adjust based on your needs
        calendar.heightAnchor.constraint(equalToConstant: calendarHeight).isActive = true
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: calendarHeight)
    }
    
    private func configureModalPresentation() {
        if let sheet = self.sheetPresentationController {
            sheet.detents = [.large()] // Medium과 Large 높이 설정
            sheet.preferredCornerRadius = 10 // 모서리 곡률 설정
        }
    }
    
    // FSCalendarDelegateAppearance Methods
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        if Calendar.current.isDateInToday(date) {
            return .white // Change today’s date text color
        }
        return appearance.titleDefaultColor
    }
    
    private func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleFontFor date: Date) -> UIFont? {
        if Calendar.current.isDateInToday(date) {
            return UIFont.systemFont(ofSize: 16, weight: .medium) // Change today’s date font size
        }
        return appearance.titleFont
    }
}

