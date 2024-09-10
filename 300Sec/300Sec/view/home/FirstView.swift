//
//  FirstView.swift
//  300Sec
//
//  Created by arthur on 8/23/24.
//

import Foundation
import UIKit

class FirstView: UIView {
    
    let weeklyCalendarView: WeeklyCalendarView = {
           let view = WeeklyCalendarView()
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    private func setUp() {
        [
            weeklyCalendarView,

        ].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            // 추가내용: 주간 달력 뷰의 제약 조건
            weeklyCalendarView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            weeklyCalendarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            weeklyCalendarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            weeklyCalendarView.heightAnchor.constraint(equalToConstant: 80),
            
        ])
    }
}
