//
//  RateView.swift
//  FlyingPopcornApp
//
//  Created by t2023-m0019 on 12/16/24.
//

import UIKit

import SnapKit
import Then

final class RateView: UIView {
    var maxStars: Int = 5 // Maximum number of stars
    var currentStar: Double = 0.0 { // Current rating value
        didSet {
            bind() // Update the stars when the current rating changes
        }
    }
    
    private var starImages: [UIImageView] = []
    
    lazy var stackView = UIStackView().then { $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .leading
        $0.distribution = .fillEqually
        $0.backgroundColor = .clear
    }
    
    lazy var starFillImage: UIImage? = {
        return UIImage(named: "icStarOn") // Filled star image
    }()
    
    lazy var starEmptyImage: UIImage? = {
        return UIImage(named: "icStarOff") // Empty star image
    }()
    
    lazy var starHalfImage: UIImage? = {
        return UIImage(named: "icStarOn") // Half-star image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(stackView)
    }
    
    private func setupLayout() {
        stackView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func bind() {
        let fullStars = Int(currentStar)
        let hasHalfStar = (currentStar - Double(fullStars)) >= 0.5
        
        while starImages.count < maxStars {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            starImages.append(imageView)
            stackView.addArrangedSubview(imageView)
        }
        
        for i in 0..<maxStars {
            if i < fullStars {
                starImages[i].image = starFillImage // Full star (yellow)
            } else if i == fullStars && hasHalfStar {
                starImages[i].image = starHalfImage // Half star (yellow)
            } else {
                starImages[i].image = starEmptyImage // Empty star (gray)
            }
        }
    }

    override var intrinsicContentSize: CGSize {
        let starSize: CGFloat = 24
        let spacing: CGFloat = 8 // Space between the stars
        let width = CGFloat(maxStars) * starSize + CGFloat(maxStars - 1) * spacing
        let height: CGFloat = starSize // Height of one star
        
        return CGSize(width: width, height: height)
    }
}
