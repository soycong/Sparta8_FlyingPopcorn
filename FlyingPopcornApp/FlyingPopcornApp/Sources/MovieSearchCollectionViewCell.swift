//
//  MovieSearchCollectionViewCell.swift
//  FlyingPopcornApp
//
//  Created by seohuibaek on 12/16/24.
//
import UIKit

final class MovieSearchCollectionViewCell: UICollectionViewCell {
    private let movieImageView = UIImageView().then {
        $0.image = UIImage(named: "MoviePoster1")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
        //$0.layer.borderWidth = 10
        //$0.layer.borderColor = UIColor.white.cgColor
    }
    
    private let movieTitleLabel = UILabel().then {
        $0.text = "영화 제목입니다!!"
        $0.font = .systemFont(ofSize: 15)
    }
    
    private let movieGenreLabel = UILabel().then {
        $0.text = "영화 장르입니다!!"
        $0.font = .systemFont(ofSize: 12)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 16
        
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(movieImageView)
        self.addSubview(movieTitleLabel)
        self.addSubview(movieGenreLabel)
    }
    
    private func configureConstraints() {
        movieImageView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(5)
            make.leading.equalTo(self).offset(5)
            make.trailing.equalTo(self).offset(-5)
            make.bottom.equalTo(self).offset(-5) // 하단에 5의 여백 추가
//            make.top.leading.trailing.equalTo(self)
//            make.width.equalTo(itemWidth)
//            make.height.equalTo(self.snp.width).multipliedBy(1.5) // 세로 길이를 가로 길이에 1.5배 비율로 설정
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).offset(5)
            make.leading.equalTo(self).offset(5)
            make.trailing.equalTo(self).offset(-5)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(movieTitleLabel.snp.bottom).offset(5)
            make.leading.equalTo(self).offset(5)
            make.trailing.equalTo(self).offset(-5)
        }
    }
}
