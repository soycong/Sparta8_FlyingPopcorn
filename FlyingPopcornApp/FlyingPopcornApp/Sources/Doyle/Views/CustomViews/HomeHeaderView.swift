//
//  HeaderView.swift
//  FlyingPopcornApp
//
//  Created by t0000-m0112 on 2024-12-16.
//

import UIKit

import SnapKit
import Then

final class HomeHeaderView: UICollectionReusableView {
    static let identifier = "HomeHeaderView"
    
    private let titleLabel = UILabel().then {
        $0.textColor = .fp800
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 데이터 설정 메서드
    func configure(with title: String, andSize size: CGFloat) {
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: size)
    }
}
