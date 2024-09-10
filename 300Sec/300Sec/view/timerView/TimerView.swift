//
//  TimerView.swift
//  300Sec
//
//  Created by arthur on 8/24/24.
//

import UIKit
import AVFoundation

class TimerView: UIView {
    
    private let timerCircleLayer = CAShapeLayer()
    private let timerCircleBackgroundLayer = CAShapeLayer()
    private var timerDuration: TimeInterval = 300 // 기본 5분
    private var countdownTimer: Timer?

    var countdownLabel: UILabel!
    
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.layer.cornerRadius = 10
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let workoutTimerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.monospacedSystemFont(ofSize: 37, weight: UIFont.Weight.bold)
        label.text = "5 Minutes"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.monospacedSystemFont(ofSize: 73, weight: UIFont.Weight.medium)
        label.textColor = .orange
        label.textAlignment = .center
        label.isHidden = true
        label.adjustsFontSizeToFitWidth = false // 자동 크기 조정을 비활성화 하기
        return label
    }()
    
    let horizontalStackViewButton: UIStackView = {
        let horizontalStackViewButton = UIStackView()
        horizontalStackViewButton.axis = .horizontal
        horizontalStackViewButton.spacing = 40
        horizontalStackViewButton.alignment = .center
        horizontalStackViewButton.distribution = .fillEqually
        horizontalStackViewButton.translatesAutoresizingMaskIntoConstraints = false
        return horizontalStackViewButton
    }()
    
    let pauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Pause", for: .normal)
        button.backgroundColor = UIColor.red.withAlphaComponent(0.2)
        button.setTitleColor(.red, for: .normal)
        button.layer.cornerRadius = 45
        return button
    }()
    
    let roundCountLabel: UILabel = {
        let roundCountLabel = UILabel()
        roundCountLabel.text = "0"
        roundCountLabel.textColor = .white
        roundCountLabel.font = .boldSystemFont(ofSize: 60)
        roundCountLabel.textAlignment = .center
        roundCountLabel.translatesAutoresizingMaskIntoConstraints = false
        return roundCountLabel
    }()
    
    let roundRepsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("R-Count", for: .normal)
        button.backgroundColor = UIColor.gray.withAlphaComponent(0.5) //투명도 적용
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 45
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupCircularTimer()
        setupCountdownLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .black
    
        
        addSubview(tableView)
        addSubview(workoutTimerLabel)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.16),
            
            workoutTimerLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 25),
            workoutTimerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            workoutTimerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            workoutTimerLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.07)
        ])
        
        // 최대 너비를 계산하여 레이블의 너비를 고정합니다.
        let maxWidthText = "88:88"
        let fixedWidth = maxWidthText.width(font: .systemFont(ofSize: 110, weight: .bold)).ceiling(to: 1)

        // TimerView의 원형 링을 감싸는 컨테이너 뷰를 추가합니다.
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        
        containerView.addSubview(timerLabel)
        
        // 컨테이너 뷰가 화면의 가운데에 오도록 제약을 설정합니다.
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5), // 화면 크기에 비례하여 크기 설정
            containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor)   // 정사각형 모양 유지
        ])
        
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            timerLabel.widthAnchor.constraint(equalToConstant: fixedWidth),
            timerLabel.heightAnchor.constraint(equalToConstant: 120)

        ])
        
        addSubview(horizontalStackViewButton)
        
        horizontalStackViewButton.addArrangedSubview(pauseButton)
        horizontalStackViewButton.addArrangedSubview(roundCountLabel)
        horizontalStackViewButton.addArrangedSubview(roundRepsButton)
        
        NSLayoutConstraint.activate([
            horizontalStackViewButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 50),
            horizontalStackViewButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            horizontalStackViewButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            horizontalStackViewButton.heightAnchor.constraint(equalToConstant: 100)
        ])
        NSLayoutConstraint.activate([
            pauseButton.heightAnchor.constraint(equalToConstant: 90),
            pauseButton.widthAnchor.constraint(equalToConstant: 90),
            
            roundCountLabel.heightAnchor.constraint(equalToConstant: 90),
            roundCountLabel.widthAnchor.constraint(equalToConstant: 90),
            
            roundRepsButton.heightAnchor.constraint(equalToConstant: 90),
            roundRepsButton.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func setupCircularTimer() {
        
        // 타이머의 원형 경로를 설정합니다. 초기 경로는 지정된 크기로 설정합니다.
         let circlePath = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: min(bounds.width, bounds.height) * 0.45, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * CGFloat.pi, clockwise: true)

        timerCircleBackgroundLayer.path = circlePath.cgPath
        timerCircleBackgroundLayer.fillColor = UIColor.clear.cgColor
        timerCircleBackgroundLayer.strokeColor = UIColor.gray.cgColor
        timerCircleBackgroundLayer.lineWidth = 11
        timerCircleBackgroundLayer.lineDashPattern = [2, 10] // 점선 패턴 (10포인트 선, 5포인트 빈 공간)
        timerCircleBackgroundLayer.strokeEnd = 1.0
        
        timerCircleLayer.path = circlePath.cgPath
        timerCircleLayer.fillColor = UIColor.clear.cgColor
        timerCircleLayer.strokeColor = UIColor.systemBlue.cgColor
        timerCircleLayer.lineWidth = 11
        timerCircleLayer.lineCap = .round // 끝을 둥글게 설정
        timerCircleLayer.strokeEnd = 0.0
        
        layer.addSublayer(timerCircleBackgroundLayer)
        layer.addSublayer(timerCircleLayer)
        
        // 타이머 링의 크기와 위치를 중앙으로 조정합니다.
        timerCircleLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        timerCircleBackgroundLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private func setupCountdownLabel() {
        countdownLabel = UILabel()
        countdownLabel.translatesAutoresizingMaskIntoConstraints = false
        countdownLabel.font = UIFont.monospacedSystemFont(ofSize: 97, weight: .bold)
        countdownLabel.textColor = .orange
        countdownLabel.textAlignment = .center
        countdownLabel.text = "10" // 초기 카운트다운 표시
        countdownLabel.isHidden = true // 초기에는 숨김
        addSubview(countdownLabel)
        
        NSLayoutConstraint.activate([
            countdownLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            countdownLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            countdownLabel.widthAnchor.constraint(equalToConstant: 200),
            countdownLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    // 메인 타이머 업데이트
    func updateMainTimerLabel(with timeString: String) {
        timerLabel.text = timeString
    }
    
    // 뷰가 변경될 때마다 레이어의 경로를 업데이트
    override func layoutSubviews() {
        super.layoutSubviews()
        updateTimerCirclePath()
        
    }

    private func updateTimerCirclePath() {
        // 링의 크기를 containerView의 크기에 맞추기 위해 크기를 계산
        let diameter = min(bounds.width, bounds.height) * 0.7
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: diameter / 2, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * CGFloat.pi, clockwise: true)
        
        timerCircleLayer.path = circlePath.cgPath
        timerCircleBackgroundLayer.path = circlePath.cgPath

        // CAShapeLayer의 크기와 위치를 설정
        timerCircleLayer.frame = bounds
        timerCircleBackgroundLayer.frame = bounds
    }
    
    func updateTimerProgress(for progress: CGFloat) {
        timerCircleLayer.strokeEnd = progress
    }

}

// extension String
extension String {
    func width(font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}

// extension CGFloat
extension CGFloat {
    func ceiling(to scale: CGFloat) -> CGFloat {
        return ceil(self / scale) * scale
    }
}
