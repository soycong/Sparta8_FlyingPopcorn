//
//  MovieDetailView.swift
//  FlyingPopcornApp
//
//  Created by t2023-m0019 on 12/15/24.
//

import UIKit
import SnapKit

final class MovieDetailView: UIView {
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let bookingButton: UIButton = {
        let button = UIButton()
        button.setTitle("예매하기", for: .normal)
        button.backgroundColor = UIColor(named: "red")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 24
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "wall-e")
        return imageView
    }()
    
    private let roundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "white")
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "WALL-E"
        label.textColor = UIColor(named: "greyDark3")
        return label
    }()
    
    private let secondStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let runtimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(named: "greyLight2")
        label.text = "Runtime: 120 mins"
        return label
    }()
    
    private let releaseDatLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(named: "greyLight2")
        label.text = "Jan 12, 2022"
        return label
    }()
    
    private let starView = RateView()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(named: "greyLight2")
        label.text = "Score: 8.5"
        return label
    }()
    
    private let genreView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(named: "greyDark3")
        label.text = "Action"
        return label
    }()
    
    private let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(named: "greyDark3")
        label.text = "Plot Summary"
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(named: "greyLight2")
        label.numberOfLines = 0
        return label
    }()
    
    private var starImageViews: [UIImageView] = []

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        backgroundColor = UIColor(named: "white")
        
        addSubViews([scrollView, bookingButton])
        scrollView.addSubview(contentView)
        
        contentView.addSubViews([imageView, roundView])
        roundView.addSubViews([titleLabel,
                               secondStackView,
                               genreLabel,
                               scoreLabel,
                               descriptionTitleLabel,
                               descriptionLabel,
                               starView])

        
        secondStackView.addArrangedSubViews([runtimeLabel, releaseDatLabel])
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bookingButton.snp.top)
        }
        
        bookingButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.trailing.equalTo(contentView)
            make.height.equalTo(200)
        }
        
        roundView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(-16)
            make.leading.trailing.equalTo(contentView)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(roundView.snp.top).offset(16)
            make.leading.trailing.equalTo(roundView).inset(16)
        }
        
        secondStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(roundView).inset(16)
        }

        starView.snp.makeConstraints { make in
            make.top.equalTo(secondStackView.snp.bottom).offset(8)
            make.leading.equalTo(roundView).inset(16)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.top.equalTo(secondStackView.snp.bottom).offset(8)
            make.leading.equalTo(starView.snp.trailing).offset(8)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(scoreLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(roundView).inset(16)
        }
        
        descriptionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(roundView).inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(roundView).inset(16)
            make.bottom.equalTo(roundView.snp.bottom).offset(-16)
        }
        
        // Layout star image views
        for (index, starImageView) in starImageViews.enumerated() {
            starImageView.snp.makeConstraints { make in
                make.top.equalTo(secondStackView.snp.bottom).offset(8)
                make.leading.equalTo(roundView).offset(CGFloat(index) * 30)
                make.width.height.equalTo(24) // 높이와 너비를 24로 설정
            }
        }
    }
    
    func configureView(with movie: SYMovie) {
        titleLabel.text = movie.title
        
        // Use voteAverage directly since it's a Float
        let rating = movie.voteAverage
        if rating > 0 {
            let normalizedRating = (rating / 10.0) * 5.0
            starView.currentStar = normalizedRating
            scoreLabel.text = "\(String(format: "%.1f", normalizedRating)) / 5"
        } else {
            scoreLabel.text = "Invalid rating"
        }
        
        // Debug print (optional)
        print("movie.voteAverage: \(movie.voteAverage)")
        
        // Set other properties
        genreLabel.text = movie.genres.joined(separator: ", ") // Join genres if you want them listed
        runtimeLabel.text = "Runtime: 120 mins"  // Update if you have runtime information
        descriptionLabel.text = movie.overview
        imageView.image = UIImage(named: "wall-e")  // Or load the image from movie.posterURL
    }

}
