//
//  PersonalCell.swift
//  300Sec
//
//  Created by arthur on 8/25/24.
//

import UIKit

class PersonalCell: UITableViewCell {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .clear
        stackView.spacing = 10
        stackView.alignment = .center // alignment를 leading으로 설정하여 레이블이 왼쪽에 정렬되도록 합니다.
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // 순번을 표시하는 레이블
    let orderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .left
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal) // 레이블의 수평 크기 증가 우선순위를 높입니다.
        return label
    }()
    
    // 운동 종목을 표시하는 레이블
    let exerciseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.textAlignment = .left
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal) // 수평 압축 저항 우선순위를 높입니다.
        return label
    }()
    
    // 반복 횟수를 표시하는 레이블
    let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .right
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal) // 레이블의 수평 크기 증가 우선순위를 높입니다.
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        
        // 배경 색상 설정
        contentView.backgroundColor = .clear
        backgroundColor = .clear // 셀의 배경 색상을 투명으로 설정

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    private func setupLayout() {
        // 레이블들을 셀의 내용 뷰에 추가합니다.
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(orderLabel)
        stackView.addArrangedSubview(exerciseLabel)
        stackView.addArrangedSubview(countLabel)
        
        // 오토 레이아웃 제약 조건 설정
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    // 셀을 설정하는 메서드
    func configure(with item: ExerciseItem, order: Int) {
        orderLabel.text = "\(order)."
        exerciseLabel.text = item.exercise.rawValue
        countLabel.text = "\(item.count)"
    }
    
    // 셀의 텍스트 색상을 설정하는 메서드
    func setTextColor(_ color: UIColor) {
        orderLabel.textColor = color
        exerciseLabel.textColor = color
        countLabel.textColor = color
    }
}
