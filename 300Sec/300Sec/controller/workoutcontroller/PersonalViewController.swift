//
//  PersonalViewController.swift
//  300Sec
//
//  Created by arthur on 8/23/24.
//

import UIKit
import MessageUI

class PersonalViewController: UIViewController {

    private let personalView = PersonalView()
    
    // 운동 데이터를 저장할 배열
    private var exerciseItems: [ExerciseItem] = []
    
    override func loadView() {
        view = personalView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.09188667685, green: 0.09461390227, blue: 0.1146789864, alpha: 1)
        
        // 테이블 뷰 설정
        personalView.tableView.dataSource = self
        personalView.tableView.delegate = self
        personalView.tableView.register(PersonalCell.self, forCellReuseIdentifier: "PersonalCell") // 커스텀 셀 등록
        
        // 운동 데이터를 초기화합니다.
        exerciseItems = ExerciseModel.getRandomWorkout()
        
        // 테이블 뷰 셀이 균등하게 보이도록 설정합니다.
        personalView.tableView.rowHeight = UITableView.automaticDimension
        personalView.tableView.estimatedRowHeight = 100
        
        recombinationButtonTapped()
        feedbackButtonTapped()
        startButtonTapped()
    }
    
    private func recombinationButtonTapped() {
        personalView.recombinationButton.addTarget(self, action: #selector(recombinationButtonAction), for: .touchUpInside)
    }
    
    private func feedbackButtonTapped() {
        personalView.feedbackButton.addTarget(self, action: #selector(sendFeedbackEmail), for: .touchUpInside)
    }
    
    @objc private func recombinationButtonAction() {
        // 새로운 랜덤 운동 데이터를 가져옵니다.
        exerciseItems = ExerciseModel.getRandomWorkout()
        // 테이블 뷰를 새로 고침합니다.
        personalView.tableView.reloadData()
    }
    
    private func startButtonTapped() {
        personalView.startButton.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
    }
    
    @objc private func startButtonAction() {
        let timerViewController = TimerViewController()
        // 전체 운동 아이템을 전달
        timerViewController.configure(with: exerciseItems)
        navigationController?.pushViewController(timerViewController, animated: true)
    }
}

extension PersonalViewController: UITableViewDataSource {
    // 테이블 뷰의 섹션당 행 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseItems.count
    }
    
    // 각 셀의 내용을 구성합니다.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalCell", for: indexPath) as? PersonalCell else {
            return UITableViewCell()
        }
        
        // 운동 아이템 데이터를 셀에 설정
        let exerciseItem = exerciseItems[indexPath.row]
        let order = indexPath.row + 1  // 순번
        
        cell.configure(with: exerciseItem, order: order)
        
        return cell
    }
}

extension PersonalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50 // 원하는 셀 높이
    }
}

extension PersonalViewController: MFMailComposeViewControllerDelegate {
    
    @objc private func sendFeedbackEmail() {
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
