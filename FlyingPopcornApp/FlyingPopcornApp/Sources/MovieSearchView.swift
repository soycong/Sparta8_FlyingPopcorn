//
//  MovieSearchView.swift
//  FlyingPopcornApp
//
//  Created by seohuibaek on 12/16/24.
//
import UIKit
import SnapKit

final class MovieSearchView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    private let collectionView = UICollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        
        configureCollectionView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCollectionView() {
        //collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        self.addSubview(collectionView)
    }
    
    private func configureConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}
