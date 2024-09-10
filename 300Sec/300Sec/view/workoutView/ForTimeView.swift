//
//  ForTimeView.swift
//  300Sec
//
//  Created by arthur on 9/5/24.
//
import UIKit

class ForTimeView: UIView {
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let verticalStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 10
        verticalStackView.layer.cornerRadius = 10
        verticalStackView.layer.masksToBounds = true // 코너를 잘라내기 위해 추가
        verticalStackView.backgroundColor = .white // 배경 색상 추가
        verticalStackView.distribution = .fillProportionally
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        return verticalStackView
    }()
    
    // 랜덤 이미지를 저장할 배열
    let workoutImages: [UIImage] = [
        UIImage(named: "workout1") ?? UIImage(),
        UIImage(named: "workout2") ?? UIImage(),
        UIImage(named: "workout3") ?? UIImage(),
        UIImage(named: "workout4") ?? UIImage(),
        UIImage(named: "workout5") ?? UIImage(),
        UIImage(named: "workout6") ?? UIImage(),
        UIImage(named: "workout7") ?? UIImage(),
        UIImage(named: "workout8") ?? UIImage(),
        UIImage(named: "workout9") ?? UIImage(),
        UIImage(named: "workout10") ?? UIImage(),
        UIImage(named: "workout11") ?? UIImage()
    ]
    
    // 이미지뷰 생성
    let workoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    let subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        let mainTitle = "300s AMRAP\n"
        let subTitle = "As Many Round As Possible"
        let attributedString = NSMutableAttributedString(string: mainTitle, attributes: [
            .font: UIFont.systemFont(ofSize: 21, weight: .bold),
            .foregroundColor: UIColor.black
        ])
        let subtitleAttributed: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17),
            .foregroundColor: UIColor.black,
            .paragraphStyle: {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                paragraphStyle.alignment = .center
                return paragraphStyle
            }()
        ]
        attributedString.append(NSAttributedString(string: subTitle, attributes: subtitleAttributed))
        subtitleLabel.attributedText = attributedString
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        return subtitleLabel
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorColor = .black
        tableView.register(PersonalCell.self, forCellReuseIdentifier: "PersonalCell") // 커스텀 셀 등록
        return tableView
    }()
    
    let horizontalStackView: UIStackView = {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 10
        horizontalStackView.alignment = .fill
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        return horizontalStackView
    }()
    
    let recombinationButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Re-Combination", for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.backgroundColor = UIColor.red
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let feedbackButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Send a feedback", for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.09188667685, green: 0.09461390227, blue: 0.1146789864, alpha: 1)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(containerView)
        containerView.addSubview(verticalStackView)
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            
            verticalStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            verticalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            verticalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            verticalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
            
        ])
        
        setupVerticalStackView()
    }
    
    private func setupVerticalStackView() {
        verticalStackView.addArrangedSubview(workoutImageView)
        verticalStackView.addArrangedSubview(subtitleLabel)
        verticalStackView.addArrangedSubview(tableView)
        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(startButton)
        
        horizontalStackView.addArrangedSubview(feedbackButton)
        horizontalStackView.addArrangedSubview(recombinationButton)
        
        // 요소들의 높이를 제약 조건으로 추가
        NSLayoutConstraint.activate([
            
            workoutImageView.heightAnchor.constraint(equalTo: verticalStackView.heightAnchor, multiplier: 0.3),
            
            subtitleLabel.heightAnchor.constraint(equalTo: verticalStackView.heightAnchor, multiplier: 0.1),
            
            tableView.heightAnchor.constraint(equalToConstant: 200),
            
            horizontalStackView.heightAnchor.constraint(equalTo: verticalStackView.heightAnchor, multiplier: 0.1),
            
            startButton.heightAnchor.constraint(equalTo: verticalStackView.heightAnchor, multiplier: 0.1)
            
        ])
        
        // 랜덤 이미지 표시
        displayRandomImage()
    }
    
    // 랜덤 이미지를 선택하여 표시하는 함수
    private func displayRandomImage() {
        // 배열에서 랜덤으로 하나의 이미지 선택
        let randomIndex = Int.random(in: 0..<workoutImages.count)
        let randomImage = workoutImages[randomIndex]
        
        // 선택한 이미지를 이미지뷰에 설정
        workoutImageView.image = randomImage
    }
}

