//
//  MyPageTableViewCell.swift
//  FlyingPopcornApp
//
//  Created by seohuibaek on 12/17/24.
//
import UIKit

final class MyPageTableViewCell: UITableViewCell {
    
    private let movieImageView = UIImageView().then {
        $0.image = UIImage(named: "MoviePoster2")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    private let movieTitleLabel = UILabel().then {
        $0.text = "MovieTitle"
        $0.font = .boldSystemFont(ofSize: 14)
        $0.textColor = UIColor(named: "grayDark3")
        $0.textAlignment = .left
    }
    
    private let movieGenreLabel = UILabel().then {
        $0.text = "MovieGenre"
        $0.font = .systemFont(ofSize: 10)
        $0.textColor = UIColor(named: "grayLight3")
        $0.textAlignment = .left
    }
    
    private let movieRunTimeLabel = UILabel().then {
        $0.text = "movieRunTime"
        $0.font = .systemFont(ofSize: 10)
        $0.textColor = UIColor(named: "grayLight3")
        $0.textAlignment = .left
    }
    
    private let movieScheduleLabel = UILabel().then {
        $0.text = "movieSchedule"
        $0.font = .systemFont(ofSize: 10)
        $0.textColor = UIColor(named: "grayLight3")
        $0.textAlignment = .left
    }
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [movieTitleLabel, movieGenreLabel, movieRunTimeLabel, movieScheduleLabel]).then {
            $0.axis = .vertical
            $0.spacing = 10
            $0.alignment = .center
            $0.distribution = .fill
        }
        return stackView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [movieImageView, verticalStackView]).then {
            $0.axis = .horizontal
            $0.spacing = 5
            $0.alignment = .center
            $0.distribution = .fill
            $0.backgroundColor = .white
        }
        return stackView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        self.layer.cornerRadius = 16
        
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(horizontalStackView)
    }
    
    private func configureConstraints() {
        
        horizontalStackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(5)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(5)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).inset(5)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).inset(5)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(self.horizontalStackView.snp.top).inset(5)
            make.bottom.equalTo(self.horizontalStackView.snp.bottom).inset(5)
            //make.leading.equalTo(self.horizontalStackView.snp.leading).inset(5)
            //make.trailing.equalTo(self.horizontalStackView.snp.trailing).inset(5)
        }
        
        let itemWidth = (UIScreen.main.bounds.width - 52) / 3 // 각 셀의 너비 계산 (leading + trailing 여백 제외)
        movieImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.horizontalStackView.snp.leading)
            make.width.equalTo(itemWidth)
            make.height.equalTo(itemWidth*1.5)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(14)
            make.top.equalTo(self.verticalStackView.snp.top)
            make.leading.equalTo(self.verticalStackView.snp.leading)
            make.trailing.equalTo(self.verticalStackView.snp.trailing)
        }
        
        movieGenreLabel.snp.makeConstraints { make in
            make.height.equalTo(10)
            make.leading.equalTo(self.verticalStackView.snp.leading)
            make.trailing.equalTo(self.verticalStackView.snp.trailing)
        }
        
        movieRunTimeLabel.snp.makeConstraints { make in
            make.height.equalTo(10)
            make.leading.equalTo(self.verticalStackView.snp.leading)
            make.trailing.equalTo(self.verticalStackView.snp.trailing)
        }
        
        movieScheduleLabel.snp.makeConstraints { make in
            make.height.equalTo(10)
            make.leading.equalTo(self.verticalStackView.snp.leading)
            make.trailing.equalTo(self.verticalStackView.snp.trailing)
        }
    }
}
