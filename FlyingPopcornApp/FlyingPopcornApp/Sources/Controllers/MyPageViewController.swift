//
//  MyPageViewController.swift
//  FlyingPopcornApp
//
//  Created by seohuibaek on 12/17/24.
//

import UIKit

final class MyPageViewController: UIViewController {
    //private let userInformationView = UserInformationView()
    private let myPageView = MyPageView()
    private var tickets: [Ticket] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = myPageView
        view.backgroundColor = .fp100
        
        myPageView.delegate = self
        myPageView.loginDelegate = self
        
        configureUI()
        updateUserInformation()
        loadTickets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTickets()
    }
    
    private func configureUI() {
        navigationItem.title = "MyPage"
    }
}

extension MyPageViewController: MyPageViewDelegate {

    private func loadTickets() { //변경 되었다면 업데이트
        let oldCount = tickets.count
        let newTickets = Tickets.bookedTickets
        
        if oldCount < newTickets.count {
            let insertedIndexes = Array(oldCount..<newTickets.count)
            tickets = newTickets
            
            let indexPaths = insertedIndexes.map { IndexPath(row: $0, section: 0) }
            myPageView.insertRows(at: indexPaths, with: .automatic)
        }
    }
    
    func numberOfItems() -> Int {
        return tickets.count
    }
    
    func ticket(at index: Int) -> Ticket {
        return tickets[index]
    }
}

// 유저 데이터 업데이트
extension MyPageViewController {
    private func updateUserInformation() {
        let userData = UserData.shared
        myPageView.updateUserInformation(with: userData)
    }
}

extension MyPageViewController: MyPageViewLoginDelegate {
    func myPageViewDidRequestLogin() {
        let alert = UIAlertController(title: "로그인이 필요합니다.",
                                      message: "로그인 하시겠습니까?",
                                      preferredStyle: .alert)
                
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            print("확인 버튼 누름")
            
            // 로그인 화면으로 이동
            let signInVC = SigninViewController()
            let signInNavController = UINavigationController(rootViewController: signInVC)
            signInNavController.modalPresentationStyle = .fullScreen
            
            // 현재 윈도우 가져와서 루트 변경
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? UIWindowSceneDelegate,
               let window = sceneDelegate.window {
                window?.rootViewController = signInNavController
                window?.makeKeyAndVisible()
            }
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .destructive, handler: nil))
            
        self.present(alert, animated: true, completion: nil)
    }
}
