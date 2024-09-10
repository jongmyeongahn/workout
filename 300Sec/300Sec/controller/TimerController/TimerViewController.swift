//
//  TimerViewController.swift
//  300Sec
//
//  Created by arthur on 8/24/24.
//
import UIKit
import AVFoundation
import MessageUI

class TimerViewController: UIViewController {
    
    private let timerView = TimerView()
//    private let tableView = UITableView()
    private var timer: Timer?
    private var elapsedTime: Int = 300 // 300초 (5분)으로 초기화
    private var isInMinutesMode: Bool = false
    private var exercises: [ExerciseItem] = [] // 전체 운동 배열 추가
    private var currentExerciseIndex: Int = 0 // 현재 운동 인덱스 추가
    private var audioPlayer: AVAudioPlayer?
    private var hasPlayedThreeSecondSound: Bool = false // 3초 알람 소리가 재생되었는지 추적
    private var titleText: String?
    
    // 카운터추가사항: 카운트다운이 진행 중인지 상태 추적
    private var isCountdownActive: Bool = false
    private var countdownTimer: Timer? // 카운터추가사항: 카운트다운 타이머
    private var countdownDuration: TimeInterval = 10 // 10초 카운트다운
    
    
    override func loadView() {
        view = timerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        if let titleText = titleText {
            navigationItem.title = titleText
        }
        timerView.tableView.dataSource = self
            timerView.tableView.delegate = self
            timerView.tableView.register(PersonalCell.self, forCellReuseIdentifier: "PersonalCell")
        
        setupNavigationBar()
        setupButtons()
        updateTimerLabel()
        
        // 셀의 텍스트 색상을 흰색으로 변경
        timerView.tableView.visibleCells.forEach { cell in
            if let personalCell = cell as? PersonalCell {
                personalCell.setTextColor(.white)
            }
        }
        // 타이머가 시작되기 전에는 R-Count 버튼을 비활성화
        updateRoundCountButtonState()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startCountdown() // 화면에 나타날 때 카운트다운 시작
    }
    
    private func startCountdown() {
        startCountdown(duration: 10) { [weak self] in
            self?.startTimer() // 카운트다운 완료 후 타이머 시작
        }
    }

    // 운동 아이템 배열을 설정하는 메서드
    func configure(with exercises: [ExerciseItem]) {
        self.exercises = exercises
        if !exercises.isEmpty {
            timerView.tableView.reloadData() // 운동 데이터가 설정되면 테이블 뷰를 업데이트합니다.
        }
    }

    private func setupNavigationBar() {
        navigationItem.title = "Timer"
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonAction))
        navigationItem.leftBarButtonItem = cancelButton
    }

    private func setupButtons() {
        timerView.pauseButton.addTarget(self, action: #selector(pauseButtonAction), for: .touchUpInside)
        timerView.roundRepsButton.addTarget(self, action: #selector(roundCountButtonAction), for: .touchUpInside)
    }

    @objc private func cancelButtonAction() {
        let alert = UIAlertController(title: "Cancel", message: "Are you sure you want to cancel?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            // 타이머가 실행 중인 경우 무효화
            self.timer?.invalidate()
            self.timer = nil
            self.audioPlayer?.stop()
            self.audioPlayer = nil
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // 라벨 카운트
    @objc private func roundCountButtonAction() {
        // 현재 라운드 수를 가져온 뒤 숫자로 변환합니다.
        if let currentCountText = timerView.roundCountLabel.text,
           let currentCount = Int(currentCountText) {
            // 숫자를 1 증가시키고 다시 레이블에 반영합니다.
            let newCount = currentCount + 1
            timerView.roundCountLabel.text = "\(newCount)"
        } else {
            // 숫자로 변환되지 않는 경우 초기값 1로 설정
            timerView.roundCountLabel.text = "1"
        }
    }


    private func startCountdown(duration: TimeInterval? = nil, completion: @escaping () -> Void) {
        // duration 파라미터가 nil이면 기존의 countdownDuration을 사용
        if let duration = duration {
            countdownDuration = duration
        }

        timerView.countdownLabel.isHidden = false
        timerView.timerLabel.isHidden = true
        isCountdownActive = true // 카운트다운 활성화 상태로 설정

        countdownTimer?.invalidate()
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.countdownDuration -= 1
            if self.countdownDuration > 0 {
                self.timerView.countdownLabel.text = "\(Int(self.countdownDuration))"
            } else {
                self.countdownTimer?.invalidate()
                self.timerView.countdownLabel.isHidden = true
                self.timerView.timerLabel.isHidden = false
                self.isCountdownActive = false // 카운트다운 비활성화
                completion()
            }
        }
    }

    @objc private func pauseButtonAction() {
        if isCountdownActive {
            if countdownTimer != nil {
                countdownTimer?.invalidate() // 카운트다운 타이머 중지
                countdownTimer = nil
                timerView.pauseButton.backgroundColor = UIColor.green.withAlphaComponent(0.2)
                timerView.pauseButton.setTitle("Resume", for: .normal)
                timerView.pauseButton.setTitleColor(.green, for: .normal)
            } else {
                startCountdown(duration: countdownDuration) { [weak self] in
                    self?.startTimer() // 카운트다운 완료 후 타이머 시작
                }
                timerView.pauseButton.backgroundColor = UIColor.red.withAlphaComponent(0.2)
                timerView.pauseButton.setTitle("Pause", for: .normal)
                timerView.pauseButton.setTitleColor(.red, for: .normal)
            }
        } else {
            if timer == nil {
                startTimer() // 메인 타이머 재개
                timerView.pauseButton.backgroundColor = UIColor.red.withAlphaComponent(0.2)
                timerView.pauseButton.setTitle("Pause", for: .normal)
                timerView.pauseButton.setTitleColor(.red, for: .normal)
            } else {
                timer?.invalidate() // 메인 타이머 중지
                timer = nil
                timerView.pauseButton.backgroundColor = UIColor.green.withAlphaComponent(0.2)
                timerView.pauseButton.setTitle("Resume", for: .normal)
                timerView.pauseButton.setTitleColor(.green, for: .normal)
                updateRoundCountButtonState() // 타이머 일시정지 상태에서 버튼 비활성화
            }
        }
    }
    
    private func updateRoundCountButtonState() {
        // 타이머가 실행 중일 때만 R-Count 버튼을 활성화
        if timer != nil && elapsedTime > 0 {
            timerView.roundRepsButton.isEnabled = true // 버튼 활성화
            timerView.roundRepsButton.alpha = 1.0 // 버튼을 활성화할 때 불투명하게
        } else {
            timerView.roundRepsButton.isEnabled = false // 버튼 비활성화
            timerView.roundRepsButton.alpha = 0.5 // 버튼을 비활성화할 때 투명도 낮추기
        }
    }

    private func startTimer() {
        
        // 기존 타이머가 실행 중인 경우 무효화
        timer?.invalidate()
        timer = nil
        
        // 알람 소리 중지 및 객체 해제
        audioPlayer?.stop() // 알람 소리가 중복되는 문제를 방지하기 위해 현재 알람을 중지합니다.
        audioPlayer = nil // 알람 재생 객체를 명확히 해제합니다.
        
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.elapsedTime > 0 {
                self.elapsedTime -= 1
                self.updateTimerLabel()
                self.updateTimerProgress()
                self.playCountdownSound() // 3초 알람 소리 재생
                self.updateRoundCountButtonState() // 타이머 진행 중이므로 버튼 상태 업데이트
            } else {
                self.timer?.invalidate()
                self.timer = nil
                self.timerView.pauseButton.setTitle("Pause", for: .normal)
                self.playCompletionSound()
                self.updateRoundCountButtonState() // 타이머가 끝났으므로 버튼 상태 업데이트
//                self.moveToNextExercise() // 변경: 다음 운동으로 이동
            }
        }
        hasPlayedThreeSecondSound = false
        updateRoundCountButtonState() // 타이머가 시작되면 버튼을 활성화
    }

    private func updateTimerLabel() {
        let seconds = elapsedTime % 60
        let minutes = elapsedTime / 60
        
        let timeString: String
        // 분:초 형식으로 타이머를 표시
        timeString = String(format: "%02d:%02d", minutes, seconds)
        
//        let timeString: String
//        if isInMinutesMode {
//            timeString = String(format: "%02d:%02d", minutes, seconds)
//        } else {
//            timeString = "\(elapsedTime)" // 초 단위 표시 (앞의 0을 제거)
//        }
//        
        timerView.timerLabel.text = timeString
        timerView.timerLabel.textAlignment = .center // 레이블을 중앙에 정렬
    }
    
    private func updateTimerProgress() {
        let totalDuration = 300.0
        let progress = CGFloat(1.0 - (Double(elapsedTime) / totalDuration)) // 경과 시간에 따른 비율 계산
        timerView.updateTimerProgress(for: progress)
    }
    
    private func moveToNextExercise() {
        currentExerciseIndex += 1
        if currentExerciseIndex < exercises.count {
            // 다음 운동으로 전환
            elapsedTime = 300 // 시간 초기화 (또는 운동에 따라 설정 가능)
            hasPlayedThreeSecondSound = false // 3초 알람 소리 재생 플래그 리셋
            
        } else {
            // 모든 운동이 끝난 경우
            audioPlayer?.stop() // 변경됨: 알람 재생 중지
            audioPlayer = nil // 변경됨: 플레이어 객체 해제
            playCompletionSound()
            
        }
    }
    
    private func playCountdownSound() {
        // 타이머가 3초일 때 소리 재생
        if elapsedTime == 3 && !hasPlayedThreeSecondSound {
            hasPlayedThreeSecondSound = true
            guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Error playing countdown sound: \(error.localizedDescription)")
            }
        }
    }

    
    private func playCompletionSound() {
        // 완료 알림 표시
        let alert = UIAlertController(title: "Workout Complete", message: "Congratulations! You've completed the workout.", preferredStyle: .alert)
        
        let feedbackAction = UIAlertAction(title: "Send Feedback", style: .default) { [weak self] _ in
            self?.sendFeedbackEmail()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            // 첫 화면으로 돌아가기
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        alert.addAction(feedbackAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}


extension TimerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalCell", for: indexPath) as? PersonalCell else {
            return UITableViewCell()
        }
        
        let exerciseItem = exercises[indexPath.row]
        let order = indexPath.row + 1
        
        cell.configure(with: exerciseItem, order: order)
        cell.setTextColor(.white) // 셀의 텍스트 색상을 흰색으로 설정
        
        return cell
    }
}

extension TimerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension TimerViewController: MFMailComposeViewControllerDelegate {
    
    private func sendFeedbackEmail() {
        guard MFMailComposeViewController.canSendMail() else {
            // 이메일 기능이 사용 불가능할 때
            let alert = UIAlertController(
                title: "Email Not Available",
                message: "Please configure your email account to send feedback.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                // 첫 화면으로 돌아가기
                self.navigationController?.popToRootViewController(animated: true)
            })
            present(alert, animated: true, completion: nil)
            return
        }
        
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["jman237@naver.com"])
        mailComposeVC.setSubject("Feedback on Workout App")
        mailComposeVC.setMessageBody("Please provide your feedback here.", isHTML: false)
        
        present(mailComposeVC, animated: true, completion: nil)
    }
    
    // MFMailComposeViewControllerDelegate 메소드
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true) {
            if let error = error {
                // 이메일 전송 실패 시 처리
                let alert = UIAlertController(
                    title: "Error",
                    message: "Failed to send email. Please try again. Error: \(error.localizedDescription)",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
            } else {
                switch result {
                case .sent:
                    // 이메일 전송 성공 시 감사 메시지 표시
                    let alert = UIAlertController(
                        title: "Thank You!",
                        message: "Your feedback has been sent successfully. We appreciate your input!",
                        preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: "Complete", style: .default, handler: { _ in
                        // 알림 창에서 완료를 누르면 메인 화면으로 돌아갑니다.
                        self.navigationController?.popToRootViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                case .saved:
                    // 이메일 저장 시 알림
                    let alert = UIAlertController(
                        title: "Draft Saved",
                        message: "Your email draft has been saved.",
                        preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                case .failed:
                    // 이메일 전송 실패 시 알림
                    let alert = UIAlertController(
                        title: "Send Failed",
                        message: "Failed to send your feedback. Please try again.",
                        preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                case .cancelled:
                    // 이메일 전송 취소 시 알림 (필요에 따라 생략 가능)
                    break
                @unknown default:
                    break
                }
            }
        }
    }
}
