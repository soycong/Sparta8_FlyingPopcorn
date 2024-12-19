//
//  HomeFilterCell.swift
//  FlyingPopcornApp
//
//  Created by t0000-m0112 on 2024-12-16.
//

import UIKit

import SnapKit
import Then

final class HomeFilterCell: UICollectionViewCell {
    static let identifier = "HomeFilterCell"
    
    private let filterLabel = HomePaddedLabel().then {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI 설정
    private func setupUI() {
        contentView.addSubview(filterLabel)
        contentView.layer.cornerRadius = 6
        contentView.clipsToBounds = true
        
        filterLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 기본 셀 스타일링
        contentView.backgroundColor = .fpRedLight1
        filterLabel.textColor = .fp500
    }
    
    func updateSelectionState(isSelected: Bool) {
        if isSelected {
            contentView.backgroundColor = .fpRed
            filterLabel.textColor = .white
        } else {
            contentView.backgroundColor = .fpRedLight1
            filterLabel.textColor = .fp500
        }
    }
    
    // MARK: - 데이터 설정 메서드
    func configure(with filterName: String) {
        filterLabel.text = filterName
    }
}
