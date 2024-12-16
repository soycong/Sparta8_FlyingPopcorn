//
//  MovieSearchView.swift
//  FlyingPopcornApp
//
//  Created by seohuibaek on 12/16/24.
//
import UIKit
import SnapKit
import Then

final class MovieSearchView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout().then {
            $0.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 24, height: 200) // 셀 크기 설정
            $0.minimumLineSpacing = 16 // 세로 간격
            $0.minimumInteritemSpacing = 8 // 가로 간격
            $0.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16) // 여백 설정
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = .white
            $0.dataSource = self
            $0.delegate = self
        }
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        configureCollectionView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCollectionView() {
        collectionView.register(MovieSearchCollectionViewCell.self, forCellWithReuseIdentifier: "MovieSearchCollectionViewCell")
        //collectionView.dataSource = self
        //collectionView.delegate = self
        self.addSubview(collectionView)
    }
    
    private func configureConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieSearchCollectionViewCell", for: indexPath) as? MovieSearchCollectionViewCell else {
            fatalError("Unable to dequeue MovieSearchCollectionViewCell")
        }
        return cell
    }
}
