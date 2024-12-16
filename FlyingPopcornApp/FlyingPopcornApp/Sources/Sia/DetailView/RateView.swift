//
//  RateView.swift
//  FlyingPopcornApp
//
//  Created by t2023-m0019 on 12/16/24.
//

import UIKit
import SnapKit

final class RateView: UIView {
    var maxStars: Int = 5 // Maximum number of stars
    var currentStar: Double = 0.0 { // Current rating value
        didSet {
            bind() // Update the stars when the current rating changes
        }
    }
    
    private var starImages: [UIImageView] = []
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.alignment = .leading
        view.distribution = .fillEqually
        view.backgroundColor = .clear
        return view
    }()
    
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
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubviews()
        setupLayout()
        bind()
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
        
        // Ensure the starImages array has the required number of star image views
        while starImages.count < maxStars {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            starImages.append(imageView)
            stackView.addArrangedSubview(imageView)
        }
        
        // Update each star image based on the current rating
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
        let buttonSize: CGFloat = 24 // Width and height of each star
        let spacing: CGFloat = 8 // Space between the stars
        let width = CGFloat(maxStars) * buttonSize + CGFloat(maxStars - 1) * spacing
        let height: CGFloat = buttonSize // Height of one star
        
        return CGSize(width: width, height: height)
    }
}
