//
//  MovieDetailView.swift
//  FlyingPopcornApp
//
//  Created by t2023-m0019 on 12/15/24.
//

import UIKit
import SnapKit
import Then

final class MovieDetailView: UIView {
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    let contentView = UIView()
    
    let bookingButton = UIButton().then {
        $0.setTitle("예매하기", for: .normal)
        $0.backgroundColor = .fpRed
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 24
    }
    
    private let posterImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    private let roundView = UIView().then {
        $0.backgroundColor = .fp00
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
    }
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = .fp900
    }
    
    private let secondStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .leading
        $0.distribution = .fillProportionally
    }
    
    private let runtimeStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 5
        $0.alignment = .center
        $0.distribution = .fillProportionally
    }
    
    private let runtimeImg = UIImageView().then {
        $0.image = UIImage(named: "icTime")
        $0.contentMode = .scaleAspectFit
    }
    
    let runtimeLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = .fp400
    }
    
    private let releaseStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 5
        $0.alignment = .center
        $0.distribution = .fillProportionally
    }
    
    private let releaseImg = UIImageView().then {
        $0.image = UIImage(named: "icRelease")
        $0.contentMode = .scaleAspectFit
    }
    
    private let releaseDateLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = .fp400
    }
    
    private let starView = RateView()
    
    private let scoreLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .fp400
    }
    
    private let genreView = UIView()
    
    private let descriptionTitleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .fp900
        $0.text = "Plot Summary"
        $0.numberOfLines = 1
    }
    
    private let descriptionLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = .fp900
        $0.numberOfLines = 0
    }
    
    private var starImageViews: [UIImageView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        backgroundColor = .fp00
        
        addSubViews([scrollView, bookingButton])
        scrollView.addSubview(contentView)
        
        contentView.addSubViews([posterImage, roundView])
        roundView.addSubViews([titleLabel,
                               secondStackView,
                               genreView,
                               scoreLabel,
                               descriptionTitleLabel,
                               descriptionLabel,
                               starView])
        
        secondStackView.addArrangedSubViews([runtimeStackView, releaseStackView])
        runtimeStackView.addArrangedSubViews([runtimeImg, runtimeLabel])
        releaseStackView.addArrangedSubViews([releaseImg, releaseDateLabel])
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bookingButton.snp.top)
        }
        
        bookingButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(24)
            make.height.equalTo(48)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        posterImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(contentView)
            make.height.equalTo(250)
        }
        
        roundView.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.bottom).offset(-16)
            make.leading.trailing.equalTo(contentView)
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(roundView.snp.top).offset(16)
            make.leading.trailing.equalTo(roundView).inset(16)
        }
        
        secondStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(roundView).inset(16)
            make.height.equalTo(20)
        }

        runtimeStackView.snp.makeConstraints { make in
            make.centerY.equalTo(secondStackView.snp.centerY)
        }
        
        releaseStackView.snp.makeConstraints { make in
            make.centerY.equalTo(secondStackView.snp.centerY)
        }

        starView.snp.makeConstraints { make in
            make.top.equalTo(secondStackView.snp.bottom).offset(16)
            make.leading.equalTo(roundView).inset(16)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.centerY.equalTo(starView.snp.centerY)
            make.leading.equalTo(starView.snp.trailing).offset(16)
        }
        
        genreView.snp.makeConstraints { make in
            make.top.equalTo(scoreLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(roundView).inset(16)
            make.height.equalTo(30)
        }
        
        descriptionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(genreView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(roundView).inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(roundView).inset(16)
            make.bottom.equalTo(roundView.snp.bottom).offset(-16)
        }
        
        for (index, starImageView) in starImageViews.enumerated() {
            starImageView.snp.makeConstraints { make in
                make.top.equalTo(secondStackView.snp.bottom).offset(8)
                make.leading.equalTo(roundView).offset(CGFloat(index) * 30)
                make.width.height.equalTo(24)
            }
        }
    }
    
    private func setupGenreViews(genres: [String]) {
        genreView.subviews.forEach { $0.removeFromSuperview() }
        
        var previousView: UIView? = nil
        
        for genre in genres {
            let genreLabel = UILabel().then { $0.text = genre
                $0.font = UIFont.systemFont(ofSize: 12)
                $0.textColor = .fp800
                $0.textAlignment = .center
            }
            
            // 장르 배경 뷰
            let containerView = UIView().then { $0.layer.cornerRadius = 15
                $0.backgroundColor = .fpRedLight1
                $0.clipsToBounds = true
            }
            
            containerView.addSubview(genreLabel)
            genreView.addSubview(containerView)
            
            genreLabel.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
            }
            
            containerView.snp.makeConstraints { make in
                if let previousView = previousView {
                    make.leading.equalTo(previousView.snp.trailing).offset(8)
                } else {
                    make.leading.equalTo(genreView.snp.leading)
                }
                make.top.bottom.equalToSuperview()
            }
            
            previousView = containerView
        }
    }
    
    func configureView(with movie: Movie) {
        titleLabel.text = movie.title
        let rating = movie.voteAverage
        if rating > 0 {
            let normalizedRating = (rating / 10.0) * 5.0
            starView.currentStar = normalizedRating
            scoreLabel.text = "\(String(format: "%.1f", normalizedRating)) / 5"
        } else {
            scoreLabel.text = "Invalid rating"
        }
        //runtimeLabel.text = "Runtime: \(movie.runtime) min"
        releaseDateLabel.text = movie.releaseDate
        descriptionLabel.text = movie.overview
        
        // 포스터 이미지 로드
        if let url = URL(string: movie.posterURL) {
            posterImage.loadImage(from: url)
        }
        setupGenreViews(genres: movie.genres)
    }
}
