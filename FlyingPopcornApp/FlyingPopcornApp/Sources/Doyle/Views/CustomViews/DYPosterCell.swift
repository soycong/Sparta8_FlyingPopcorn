//
//  DYPosterCell.swift
//  FlyingPopcornApp
//
//  Created by t0000-m0112 on 2024-12-16.
//

import UIKit
import SnapKit
import Then

final class DYPosterCell: UICollectionViewCell {
    static let identifier = "DYPosterCell"
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 데이터 설정 메서드
    func configure(with movie: DYMovie) {
        let url = URL(string: movie.posterURL)
        // imageView.loadImage(from: url!)
    }
}
