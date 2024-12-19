//
//  MyPageView.swift
//  FlyingPopcornApp
//
//  Created by seohuibaek on 12/17/24.
//

import UIKit

import SnapKit
import Then

//로그인 화면 없을 경우 델리게이트
protocol MyPageViewLoginDelegate: AnyObject {
    func myPageViewDidRequestLogin()
}

protocol MyPageViewDelegate: AnyObject {
    func numberOfItems() -> Int
    func ticket(at index: Int) -> Ticket
}

final class MyPageView: UIView, UITableViewDataSource, UITableViewDelegate {
    weak var delegate: MyPageViewDelegate?
    weak var loginDelegate: MyPageViewLoginDelegate?

    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    private let userInformationView = UserInformationView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = UIColor(named: "fp100")
        configureTableView()
        userInformationView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTableView() {
        tableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: "MyPageTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "fp100")
        
        tableView.showsVerticalScrollIndicator = false //스크롤바 제거
        
        self.addSubview(tableView)
        self.addSubview(userInformationView)
        
        userInformationView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(80)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
            make.top.equalTo(self.userInformationView.snp.bottom)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        let titleLabel = UILabel().then {
            $0.text = "🍿 최근 예매 목록"
            $0.font = UIFont.boldSystemFont(ofSize: 18)
            $0.textColor = .black
        }
        
        headerView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(headerView.snp.leading).offset(16)
            make.trailing.equalTo(headerView.snp.trailing)
            make.centerY.equalTo(headerView.snp.centerY)
        }
        
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func reloadData() {
        self.tableView.reloadData()
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.numberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageTableViewCell", for: indexPath) as! MyPageTableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = .clear

        if let ticket = delegate?.ticket(at: indexPath.row) {
            cell.configureData(with: ticket)
        }
        
        return cell
    }
    
    func insertRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        tableView.insertRows(at: indexPaths, with: animation)
    }
}

// 유저 데이터 업데이트
extension MyPageView {
    func updateUserInformation(with userData: UserData) {
        if let familyName = userData.familyName,
           let name = userData.name {
            userInformationView.updateDisplay(
                name: "\(familyName) \(name)",
                email: userData.email ?? ""
            )
        } else {
            userInformationView.showLoginRequired()
        }
    }
}

extension MyPageView: UserInformationViewDelegate {
    func userInformationViewDidTapForLogin() {
        loginDelegate?.myPageViewDidRequestLogin()
    }
}
