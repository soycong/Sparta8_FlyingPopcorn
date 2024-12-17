//
//  MovieSearchCollectionViewCell.swift
//  FlyingPopcornApp
//
//  Created by seohuibaek on 12/16/24.
//
import UIKit

final class MovieSearchCollectionViewCell: UICollectionViewCell {
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
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [movieImageView, movieTitleLabel, movieGenreLabel]).then {
            $0.axis = .vertical
            $0.spacing = 5
            $0.alignment = .center
            $0.distribution = .fill
        }
        return stackView
    }()
    
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
        self.addSubview(stackView)
    }
    
    private func configureConstraints() {
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(5)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(10)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).inset(5)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).inset(5)
        }
        
        let itemWidth = (UIScreen.main.bounds.width - 52) / 3 // 각 셀의 너비 계산 (leading + trailing 여백 제외)
        movieImageView.snp.makeConstraints { make in
            make.height.equalTo(itemWidth*1.5)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(14)
            make.leading.equalTo(self.stackView.snp.leading)
            make.trailing.equalTo(self.stackView.snp.trailing)
        }
        
        movieGenreLabel.snp.makeConstraints { make in
            make.height.equalTo(10)
            make.leading.equalTo(self.stackView.snp.leading)
            make.trailing.equalTo(self.stackView.snp.trailing)
        }
    }
}

extension MovieSearchCollectionViewCell {
    func configureData(with movie: DummyMovieData) {
        movieImageView.image = UIImage(named: movie.posterImageName)
        movieTitleLabel.text = movie.title
        movieGenreLabel.text = movie.genre
    }
}