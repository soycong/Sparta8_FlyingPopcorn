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
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = UIColor(named: "grayDark3")
        $0.textAlignment = .left
    }
    
    private let movieGenreLabel = UILabel().then {
        $0.text = "MovieGenre"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = UIColor(named: "grayLight3")
        $0.textAlignment = .left
    }
    
    private let movieRunTimeLabel = UILabel().then {
        $0.text = "movieRunTime"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = UIColor(named: "grayLight3")
        $0.textAlignment = .left
    }
    
    private let movieScheduleLabel = UILabel().then {
        $0.text = "movieSchedule"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = UIColor(named: "grayLight3")
        $0.textAlignment = .left
    }

    private lazy var movieInfoStackView = UIStackView(arrangedSubviews: [movieTitleLabel, movieGenreLabel]).then {
        $0.axis = .vertical
        $0.spacing = 5
        $0.alignment = .leading
        $0.distribution = .fill
    }
    
    private lazy var scheduleInfoStackView = UIStackView(arrangedSubviews: [movieRunTimeLabel, movieScheduleLabel]).then {
        $0.axis = .vertical
        $0.spacing = 5
        $0.alignment = .leading
        $0.distribution = .fill
    }
    
    private lazy var infoContainerStackView = UIStackView(arrangedSubviews: [movieInfoStackView, scheduleInfoStackView]).then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.alignment = .leading
        $0.distribution = .equalSpacing
    }
    
    private lazy var horizontalStackView = UIStackView(arrangedSubviews: [movieImageView, infoContainerStackView]).then {
        $0.axis = .horizontal
        $0.spacing = 16
        $0.alignment = .center
        $0.distribution = .fill
        $0.backgroundColor = .white
        
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowRadius = 2
        $0.layer.masksToBounds = false
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //contentView.frame = self.bounds
        //contentView.frame = self.bounds.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        //contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }
    
    private func configureUI() {
        self.addSubview(horizontalStackView)
    }
    
    private func configureConstraints() {
        
        horizontalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16))
        }
        
        let itemWidth = (UIScreen.main.bounds.width - 52) / 3
        movieImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.horizontalStackView.snp.leading).inset(5)
            make.top.equalTo(self.horizontalStackView.snp.top).offset(5)
            make.bottom.equalTo(self.horizontalStackView.snp.bottom).offset(-5)
            make.width.equalTo(itemWidth)
            make.height.equalTo(itemWidth * 1.5)
        }
        
        infoContainerStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(15)
        }
        
        [movieTitleLabel, movieGenreLabel, movieRunTimeLabel, movieScheduleLabel].forEach { label in
            label.snp.makeConstraints { make in
                make.height.equalTo(label == movieTitleLabel ? 20 : 14)
            }
        }
    }
}

extension MyPageTableViewCell {
    func configureData(with movie: DummyMovieData) {
        movieImageView.image = UIImage(named: movie.posterImageName)
        movieTitleLabel.text = movie.title
        movieGenreLabel.text = movie.genre
        movieRunTimeLabel.text = movie.runTime
        movieScheduleLabel.text = movie.schedule
    }
}
