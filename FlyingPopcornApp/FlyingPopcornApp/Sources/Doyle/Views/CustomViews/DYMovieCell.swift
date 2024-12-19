//
//  DYMovieCell.swift
//  FlyingPopcornApp
//
//  Created by t0000-m0112 on 2024-12-16.
//

import UIKit

import SnapKit
import Then

final class DYMovieCell: UICollectionViewCell {
    static let identifier = "DYMovieCell"
    
    // MARK: - UI
    
    private let imageContainerView =  UIView().then {
        $0.backgroundColor = .clear
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 4
        $0.layer.masksToBounds = false
    }
    
    private let posterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private let titleLabel = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textColor = .fp800
        $0.numberOfLines = 1
    }
    
    private let genreLabel = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 12)
        $0.textColor = .fp400
        $0.numberOfLines = 1
    }

    private let runtimeIconView = UIImageView().then {
        $0.image = UIImage(systemName: "clock")
        $0.tintColor = .fpRed
        $0.contentMode = .scaleAspectFit
    }

    private let runtimeLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.textColor = .fp400
    }
    
    private lazy var runtimeStackView = UIStackView(arrangedSubviews: [runtimeIconView, runtimeLabel]).then{
        $0.axis = .horizontal
        $0.spacing = 3
        $0.alignment = .center
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 뷰 설정
    private func setupViews() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.masksToBounds = false
        backgroundColor = .clear
        
        contentView.backgroundColor = .fp00
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
        
        contentView.addSubview(imageContainerView)
        imageContainerView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(runtimeStackView)
        
        imageContainerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview().offset(-54)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(1)
            make.leading.equalTo(titleLabel.snp.leading)
        }
        
        runtimeStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        runtimeIconView.snp.makeConstraints { make in
            make.width.height.equalTo(12)
        }
    }
    
    // MARK: - 데이터 설정 메서드
    func configure(with movie: Movie) {
        let imageURL = URL(string: movie.posterURL)
        posterImageView.loadImage(from: imageURL!)
        titleLabel.text = movie.title
        genreLabel.text = movie.genres.prefix(2).joined(separator: ", ") // Genres에서 앞의 2개만 표시
        runtimeLabel.text = "\(movie.runtime) min"
    }
}
