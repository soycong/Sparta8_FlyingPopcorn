//
//  DYFilterCell.swift
//  FlyingPopcornApp
//
//  Created by t0000-m0112 on 2024-12-16.
//

import UIKit
import SnapKit
import Then

final class DYFilterCell: UICollectionViewCell {
    static let identifier = "DYFilterCell"
    
    private let filterLabel = DYPaddedLabel().then {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = .fpRed
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(filterLabel)
        contentView.layer.cornerRadius = 6
        contentView.clipsToBounds = true
        
        filterLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 초기 스타일 설정
        updateStyle(isSelected: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 선택 시 스타일 변경
    private func updateStyle(isSelected: Bool) {
        if isSelected {
            contentView.backgroundColor = .fpRed
            filterLabel.textColor = .red
        } else {
            contentView.backgroundColor = .fpRedLight1
            filterLabel.textColor = .black
        }
    }
    
    // MARK: - 데이터 설정 메서드
    func configure(with filterName: String) {
        filterLabel.text = filterName
    }
}
