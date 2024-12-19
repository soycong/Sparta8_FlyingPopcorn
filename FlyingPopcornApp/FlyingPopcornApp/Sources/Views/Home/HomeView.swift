//
//  HomeView.swift
//  FlyingPopcornApp
//
//  Created by t0000-m0112 on 2024-12-18.
//

import UIKit

import SnapKit

final class HomeView: UIView {
    // MARK: - Properties
    let collectionView: UICollectionView
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            // HomeViewController에서 처리될 레이아웃 로직
            return NSCollectionLayoutSection(group: NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)), subitems: []))
        }
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        backgroundColor = .fp50
        collectionView.backgroundColor = .fp50
        
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
