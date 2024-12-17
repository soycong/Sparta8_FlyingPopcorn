//
//  DetailMovieViewController.swift
//  FlyingPopcornApp
//
//  Created by t2023-m0019 on 12/16/24.
//

import UIKit

class DetailMovieViewController: UIViewController {
    private let movieDetailView = MovieDetailView()
    private var collectionView: UICollectionView!
    
    override func loadView() {
        self.view = movieDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookingButton()
        setupCollectionView()
    }
    
    func bookingButton() {
        movieDetailView.bookingButton.addTarget(self, action: #selector(bookPushView), for: .touchUpInside)
    }
    
    @objc func bookPushView() {
        print("예매하기버튼 탭")
    }
    
    private func setupCollectionView() {
        // Create a layout for your collection view
        let layout = createCompositionalLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        movieDetailView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // Register cell and supplementary view
        collectionView.register(MovieDetailCell.self, forCellWithReuseIdentifier: "MovieDetailCell")
        //collectionView.register(MovieHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MovieHeaderView")
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
        let headerItem = NSCollectionLayoutItem(layoutSize: headerSize)
        let headerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: headerSize, subitems: [headerItem])
        
        let section = NSCollectionLayoutSection(group: headerGroup)
        section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)]
        
        //section.headersPinToVisibleBounds = true // Make header sticky
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension DetailMovieViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 // For example, one item for movie details
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieDetailCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MovieHeaderView", for: indexPath)
        return headerView
    }
}
