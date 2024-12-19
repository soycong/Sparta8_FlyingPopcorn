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
    let logoImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star") // Placeholder: Replace with logo
        $0.contentMode = .scaleAspectFit
    }
    
    let searchButton = UIButton(type: .system).then {
        $0.backgroundColor = .fp00
        $0.setTitle("     Search...", for: .normal)
        $0.setTitleColor(.fp500, for: .normal)
        $0.contentHorizontalAlignment = .left
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowRadius = 3
    }
    
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
    
    // MARK: - UI 설정
    private func setupUI() {
        backgroundColor = .fp50
        collectionView.backgroundColor = .fp50
        
        let topStackView = UIStackView(arrangedSubviews: [logoImageView, searchButton])
        topStackView.axis = .horizontal
        topStackView.spacing = 12
        topStackView.alignment = .center
        topStackView.distribution = .fill
        
        addSubview(topStackView)
        addSubview(collectionView)
        
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(45)
        }
        
        searchButton.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
