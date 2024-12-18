//
//  MyPageView.swift
//  FlyingPopcornApp
//
//  Created by seohuibaek on 12/17/24.
//

import UIKit

import SnapKit
import Then

final class MyPageView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    private let userInformationView = UserInformationView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = UIColor(named: "50")
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTableView() {
        tableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: "MyPageTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none // 구분선 제거
        tableView.backgroundColor = UIColor(named: "50")
        
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
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-16)
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
            make.leading.equalTo(headerView.snp.leading)
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageTableViewCell", for: indexPath) as! MyPageTableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
//        let dummyMovieData = DummyMovieData[indexPath.row]
//        
//        cell.movieTitleLabel.text = dummyMovieData.title
//        cell.movieGenreLabel.text = dummyMovieData.genre
//        cell.movieImageView.image = dummyMovieData.posterImageName
        return cell
    }
}
