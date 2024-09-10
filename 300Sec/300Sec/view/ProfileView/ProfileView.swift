//
//  RecordView.swift
//  300Sec
//
//  Created by arthur on 9/5/24.
//

import UIKit

class ProfileView: UIView {
    
    let horizontalStackView: UIStackView = {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 10
        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        return horizontalStackView
    }()
    
    // 프로필 이미지
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 40
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "defaultProfile")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let RM1stackView1: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = -10
        return stackView
    }()
    
    let RM2stackView2: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = -10
        return stackView
    }()
    
    let RM3stackView3: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = -10
        return stackView
    }()
    
    let RM1Label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.text = "0"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let RM1underLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .light)
        label.textColor = .white
        label.text = "snatch"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let RM2Label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let RM2underLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .light)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "clean"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let RM3Label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let RM3underLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .light)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "jurk"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let goalLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .left
        label.textColor = .white
        label.text = "my workout goal"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let memoLabel: UILabel = {
        let label = UILabel()
        label.text = """
        remember my workout
        ㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇ
        ㅁㄴㅇㄹㅁㄴㅇㄹㅁ
        ㅁㄴㅇㄹㅁㄴㅇㄹ
        ㅁㄴㅇㄹㅁ
        """
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 3  // 세 줄까지만 표시
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let seeMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("more", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let profileButton: UIButton = {
        let profileButton = UIButton()
        profileButton.setTitle("Edit profile", for: .normal)
        profileButton.setTitleColor(.white, for: .normal)
        profileButton.layer.cornerRadius = 5
        profileButton.backgroundColor = #colorLiteral(red: 0.1793718636, green: 0.1793718636, blue: 0.1793718636, alpha: 1)
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        return profileButton
    }()
    
    let profilehorizontalStackView: UIStackView = {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 5
        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        return horizontalStackView
    }()
    
    let kgLbCalButton: UIButton = {
        let kgLbCalButton = UIButton()
        kgLbCalButton.setTitle("kg/lb Calculation", for: .normal)
        kgLbCalButton.setTitleColor(.white, for: .normal)
        kgLbCalButton.layer.cornerRadius = 5
        kgLbCalButton.backgroundColor = #colorLiteral(red: 0.1793718636, green: 0.1793718636, blue: 0.1793718636, alpha: 1)
        kgLbCalButton.translatesAutoresizingMaskIntoConstraints = false
        return kgLbCalButton
    }()
    
    let percentCalButton: UIButton = {
        let percentCalButton = UIButton()
        percentCalButton.setTitle("Percent Calculation", for: .normal)
        percentCalButton.setTitleColor(.white, for: .normal)
        percentCalButton.layer.cornerRadius = 5
        percentCalButton.backgroundColor = #colorLiteral(red: 0.1793718636, green: 0.1793718636, blue: 0.1793718636, alpha: 1)
        percentCalButton.translatesAutoresizingMaskIntoConstraints = false
        return percentCalButton
    }()
    
    // RM을 추가하는 버튼
    let addRMButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white // 이미지 색상
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.7
        button.layer.cornerRadius = 33
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // "Add" 텍스트 레이블
    let addTextLabel: UILabel = {
        let label = UILabel()
        label.text = "add RM"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // RM 항목을 보여줄 컬렉션 뷰
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // 뷰를 초기화하는 메소드
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        addSubview(horizontalStackView)
        
        RM1stackView1.addArrangedSubview(RM1Label)
        RM1stackView1.addArrangedSubview(RM1underLabel)
        
        RM2stackView2.addArrangedSubview(RM2Label)
        RM2stackView2.addArrangedSubview(RM2underLabel)
        
        RM3stackView3.addArrangedSubview(RM3Label)
        RM3stackView3.addArrangedSubview(RM3underLabel)
        
        horizontalStackView.addArrangedSubview(profileImageView)
        horizontalStackView.addArrangedSubview(RM1stackView1)
        horizontalStackView.addArrangedSubview(RM2stackView2)
        horizontalStackView.addArrangedSubview(RM3stackView3)
        
        addSubview(goalLable)
        addSubview(memoLabel)
        addSubview(seeMoreButton)
        
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            horizontalStackView.heightAnchor.constraint(equalToConstant: 100),
            
            goalLable.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 10),
            goalLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            goalLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            goalLable.heightAnchor.constraint(equalToConstant: 20),
            
            memoLabel.topAnchor.constraint(equalTo: goalLable.bottomAnchor, constant: 0),
            memoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            memoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            seeMoreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            seeMoreButton.bottomAnchor.constraint(equalTo: memoLabel.bottomAnchor), // 같은 줄에 위치하도록 설정
            
        ])
        
        // 오토레이아웃 설정
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            
            RM1stackView1.heightAnchor.constraint(equalToConstant: 50),
            RM2stackView2.heightAnchor.constraint(equalToConstant: 50),
            RM3stackView3.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        addSubview(profileButton)
        
        NSLayoutConstraint.activate([
            profileButton.topAnchor.constraint(equalTo: memoLabel.bottomAnchor, constant: 10),
            profileButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            profileButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
        
        addSubview(profilehorizontalStackView)
        
        profilehorizontalStackView.addArrangedSubview(kgLbCalButton)
        profilehorizontalStackView.addArrangedSubview(percentCalButton)
        
        NSLayoutConstraint.activate([
            profilehorizontalStackView.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 10),
            profilehorizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profilehorizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            profilehorizontalStackView.heightAnchor.constraint(equalToConstant: 40),
            
            kgLbCalButton.heightAnchor.constraint(equalToConstant: 40),
            percentCalButton.heightAnchor.constraint(equalToConstant: 40)
            
        ])
        
        addSubview(addRMButton)
        addSubview(addTextLabel)
        addSubview(collectionView)
        
        // 버튼과 컬렉션 뷰의 제약 조건을 설정합니다.
        NSLayoutConstraint.activate([
            addRMButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            addRMButton.widthAnchor.constraint(equalToConstant: 66),
            addRMButton.heightAnchor.constraint(equalToConstant: 66),
            addRMButton.topAnchor.constraint(equalTo: kgLbCalButton.bottomAnchor, constant: 20),
            
            // "Add" 텍스트 레이블의 제약 조건
            addTextLabel.centerXAnchor.constraint(equalTo: addRMButton.centerXAnchor),
            addTextLabel.topAnchor.constraint(equalTo: addRMButton.bottomAnchor, constant: 5),
            
            collectionView.topAnchor.constraint(equalTo: kgLbCalButton.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: addRMButton.trailingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 90)
        ])
    
        
        // 초기 '더보기' 버튼 상태 설정
        checkMemoLabel()
        
        // 버튼 클릭 시 호출될 메서드 설정
        seeMoreButton.addTarget(self, action: #selector(didTapSeeMore), for: .touchUpInside)
    }
    
    // 메모라벨을 확인하고 더보기 기능 적용
    private func checkMemoLabel() {
        DispatchQueue.main.async {
            // 텍스트가 3줄을 넘는지 확인
            let exceedsThreeLines = self.doesTextExceedThreeLines(self.memoLabel)
            
            // '더보기' 버튼을 숨기거나 보이게 설정
            self.seeMoreButton.isHidden = !exceedsThreeLines
            
            // '더보기' 버튼이 보일 때만 줄이 생략된 텍스트 설정
            if exceedsThreeLines {
                self.memoLabel.addTrailing(with: "... ", moreText: "more", moreTextFont: UIFont.systemFont(ofSize: 15), moreTextColor: UIColor.gray)
            }
        }
    }
    
    // 더보기 비활성화 기능 계산하기
    private func doesTextExceedThreeLines(_ label: UILabel) -> Bool {
        // 현재 레이블의 크기에 맞는 텍스트 높이를 계산
        let labelWidth = label.frame.width
        let labelHeight = label.font.lineHeight * 3 // 3줄의 높이 계산
        
        let size = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        let attributes = [NSAttributedString.Key.font: label.font!]
        let attributedText = NSAttributedString(string: label.text ?? "", attributes: attributes)
        
        let boundingRect = attributedText.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil)
        
        // 계산된 텍스트 높이가 3줄의 높이보다 크면 3줄을 초과한 것임
        return boundingRect.height > labelHeight
    }

    
    // '더보기' 버튼 클릭 시 전체 텍스트 표시
    @objc private func didTapSeeMore() {
        if memoLabel.numberOfLines == 3 {
            memoLabel.numberOfLines = 0 // 전체 텍스트 표시
            seeMoreButton.setTitle("folding", for: .normal) // 버튼 제목을 "접기"로 변경
        } else {
            memoLabel.numberOfLines = 3 // 다시 3줄로 제한
            seeMoreButton.setTitle("more", for: .normal) // 버튼 제목을 "더보기"로 변경
        }
    }
}

extension UILabel {
    func addTrailing(with trailingText: String, moreText: String, moreTextFont: UIFont, moreTextColor: UIColor) {
        let readMoreText = trailingText + moreText
        
        // Check if the text fits within the label
        guard let originalText = self.text, self.numberOfLines == 2 else { return }
        
        let visibleTextLength = self.visibleTextLength()
        let truncatedText = (originalText as NSString).replacingCharacters(in: NSRange(location: visibleTextLength, length: originalText.count - visibleTextLength), with: "")
        
        let attributedString = NSMutableAttributedString(string: truncatedText, attributes: [NSAttributedString.Key.font: self.font ?? UIFont.systemFont(ofSize: 17)])
        let readMoreAttributedString = NSMutableAttributedString(string: readMoreText, attributes: [NSAttributedString.Key.font: moreTextFont, NSAttributedString.Key.foregroundColor: moreTextColor])
        
        attributedString.append(readMoreAttributedString)
        self.attributedText = attributedString
    }
    
    func visibleTextLength() -> Int {
        guard let font = self.font else { return 0 }
        let mode = self.lineBreakMode
        let labelWidth = self.frame.size.width
        let labelHeight = self.font.lineHeight * CGFloat(self.numberOfLines)
        
        let size = CGSize(width: labelWidth, height: labelHeight)
        let attributes = [NSAttributedString.Key.font: font]
        let attributedText = NSAttributedString(string: self.text ?? "", attributes: attributes)
        let textStorage = NSTextStorage(attributedString: attributedText)
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: size)
        textContainer.lineBreakMode = mode
        textContainer.maximumNumberOfLines = self.numberOfLines
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        let range = NSRange(location: 0, length: layoutManager.numberOfGlyphs)
        var index = 0
        layoutManager.enumerateLineFragments(forGlyphRange: range) { _, _, _, _, stop in
            if index >= self.numberOfLines {
                stop.pointee = true
            }
            index += 1
        }
        
        return layoutManager.characterRange(forGlyphRange: NSRange(location: 0, length: layoutManager.numberOfGlyphs), actualGlyphRange: nil).length
    }
}
