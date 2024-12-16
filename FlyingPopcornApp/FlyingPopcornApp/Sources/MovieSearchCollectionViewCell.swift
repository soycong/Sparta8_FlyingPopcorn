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
    }
    
    private func configureConstraints() {
        movieImageView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(5) // 상단에 5의 여백 추가
            make.leading.equalTo(self).offset(5) // 왼쪽에 5의 여백 추가
            make.trailing.equalTo(self).offset(-5) // 오른쪽에 5의 여백 추가
            //make.bottom.equalTo(self).offset(-5) // 하단에 5의 여백 추가
//            make.top.leading.trailing.equalTo(self)
//            make.width.equalTo(itemWidth)
//            make.height.equalTo(self.snp.width).multipliedBy(1.5) // 세로 길이를 가로 길이에 1.5배 비율로 설정
        }
    }
}
