//
//  WeeklyCalendarView.swift
//  300Sec
//
//  Created by arthur on 9/3/24.
//

import UIKit

class WeeklyCalendarView: UIView {

    private let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"] // 요일 배열
    
    // 운동 기록이 저장된 배열, true면 운동한 날, false면 운동하지 않은 날
    private var exerciseData: [Bool] = [true, false, true, false, true, false, true] // 예시 데이터
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)

        // StackView 제약 조건 설정
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        // 오늘 요일 구하기
        let todayIndex = getTodayDayIndex()
        
        
        // 요일별 링 추가
        for (index, day) in days.enumerated() {
            let isToday = index == todayIndex
            let dayView = createDayView(for: day, isToday: isToday)
            stackView.addArrangedSubview(dayView)
        }
    }
    
    private func getTodayDayIndex() -> Int? {
        let calendar = Calendar.current
        let today = Date()
        let components = calendar.dateComponents([.weekday], from: today)
        guard let weekday = components.weekday else { return nil }
        return (weekday % 7 + 6) % 7
    }
    
    private func createDayView(for day: String, isToday: Bool) -> UIView {
        let dayView = UIView()

        // 요일 레이블 추가
        let dayLabel = UILabel()
        dayLabel.text = day
        dayLabel.textAlignment = .center
        dayLabel.textColor = isToday ? .systemBlue : .lightGray
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayView.addSubview(dayLabel)

        // 링 뷰 추가 (동그라미로 표현)
        let ringView = createRingView()
        dayView.addSubview(ringView)

        // 제약 조건 설정
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: dayView.topAnchor),
            dayLabel.centerXAnchor.constraint(equalTo: dayView.centerXAnchor),
            
            ringView.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 8),
            ringView.centerXAnchor.constraint(equalTo: dayView.centerXAnchor),
            ringView.widthAnchor.constraint(equalToConstant: 36),
            ringView.heightAnchor.constraint(equalToConstant: 36),
        ])

        return dayView
    }

    private func createRingView() -> UIView {
        let ringView = UIView()
        ringView.backgroundColor = .clear
        ringView.layer.cornerRadius = 18 // 반지름 설정
        ringView.layer.borderWidth = 5   // 테두리 두께 설정
        ringView.layer.borderColor = UIColor.systemBlue.cgColor // 테두리 색상 설정
        ringView.translatesAutoresizingMaskIntoConstraints = false
        return ringView
    }

}
