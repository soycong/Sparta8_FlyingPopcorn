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
        view.backgroundColor = UIColor(named: "fp100")
        
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
        print("티켓 개수 \(tickets.count)")
        return tickets.count
    }
    
    func ticket(at index: Int) -> Ticket {
        return tickets[index]
    }
}

// 유저 데이터 업데이트
extension MyPageViewController {
    private func updateUserInformation() {
        let userData = UserData.loginedUser
        myPageView.updateUserInformation(with: userData)
    }
}

extension MyPageViewController: MyPageViewLoginDelegate {
    func myPageViewDidRequestLogin() {
        let signinVC = SigninViewController()
        let navController = UINavigationController(rootViewController: signinVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
}
