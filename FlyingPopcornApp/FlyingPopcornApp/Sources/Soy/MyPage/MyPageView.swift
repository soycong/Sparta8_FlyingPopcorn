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
    
    private let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTableView() {
        tableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: "MyPageTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        self.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(0)
            make.bottom.equalTo(self.snp.bottom)
        }
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
        
//        let dummyMovieData = DummyMovieData[indexPath.row]
//        
//        cell.movieTitleLabel.text = dummyMovieData.title
//        cell.movieGenreLabel.text = dummyMovieData.genre
//        cell.movieImageView.image = dummyMovieData.posterImageName
//        
        return cell
    }
    
}
