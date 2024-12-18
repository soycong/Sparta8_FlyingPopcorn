//
//  HomeViewController.swift
//  FlyingPopcornApp
//
//  Created by t0000-m0112 on 2024-12-16.
//

import UIKit

final class HomeViewController: UIViewController {
    // MARK: - Properties
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star") // 임시 이미지: 후에 로고로 변경
        $0.contentMode = .scaleAspectFit
    }
    
    private let searchButton = UIButton(type: .system).then { // 임의의 스타일: 후에 검색 화면에 맞춰 변경
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
    
    private var collectionView: UICollectionView?
//    private var isInitialSelectionDone = false
    
    // collectionView 데이터
    private var filters: [String] = ["All", "Adventure", "Action", "Drama", "Comedy", "Horror"] // 더미 데이터
    private var allNowShowingMovies: [DYMovie] = []
    private var allComingSoonMovies: [DYMovie] = []
    private var filteredNowShowingMovies: [DYMovie] = []
    private var filteredComingSoonMovies: [DYMovie] = []
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDummyData()
        applyFilter(index: 0) // 초기 필터: "All"
    }
    
    /*
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 처음 한 번만 기본 필터가 선택되도록 처리
        if !isInitialSelectionDone {
            let firstIndexPath = IndexPath(item:0 , section: 0)
            collectionView?.selectItem(at: firstIndexPath, animated: false, scrollPosition: .left)
            collectionView(collectionView!, didSelectItemAt: firstIndexPath)
            isInitialSelectionDone = true
        }
    }
     */
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .fp50
        
        // 상단 StackView
        let topStackView = UIStackView(arrangedSubviews: [logoImageView, searchButton])
        topStackView.axis = .horizontal
        topStackView.spacing = 12
        topStackView.alignment = .center
        topStackView.distribution = .fill
        
        view.addSubview(topStackView)
        setupCollectionView()
        collectionView?.backgroundColor = .fp50
        
        // SnapKit으로 레이아웃 설정
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(45)
        }
        
        searchButton.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
        
        collectionView?.snp.makeConstraints{ make in
            make.top.equalTo(topStackView.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupCollectionView() {
        // Compositional Layout 생성
        let layout = createCompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        // CollectionView 설정
        collectionView.dataSource = self
        
        // 셀 및 헤더 등록
        collectionView.register(DYFilterCell.self, forCellWithReuseIdentifier: DYFilterCell.identifier)
        collectionView.register(DYMovieCell.self, forCellWithReuseIdentifier: DYMovieCell.identifier)
        collectionView.register(DYPosterCell.self, forCellWithReuseIdentifier: DYPosterCell.identifier)
        collectionView.register(DYHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DYHeaderView.identifier)
        
        // 컬렉션 뷰를 뷰에 추가
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }
    
    // MARK: - 더미 데이터 설정
    private func setupDummyData() {
        let dummy1 = DYMovie(
            posterURL: "https://www.tallengestore.com/cdn/shop/products/WALL_E-HollywoodAnimationClassicMoviePoster_e1aa7d6e-de2c-4476-9793-e2c7dd74e6aa.jpg?v=1591603143",
            title: "WALL-E",
            genres: ["Adventure", "Action", "Comedy", "Horror"],
            runtime: 100
        )
        
        let dummy2 = DYMovie(
            posterURL: "https://www.tallengestore.com/cdn/shop/products/WALL_E-HollywoodAnimationClassicMoviePoster_e1aa7d6e-de2c-4476-9793-e2c7dd74e6aa.jpg?v=1591603143",
            title: "WALL-E",
            genres: ["Adventure", "Action", "Horror"],
            runtime: 200
        )

        [
            dummy1,
            dummy2
        ].forEach {
            allNowShowingMovies.append($0)
            allComingSoonMovies.append($0)
        }
    }
    
    // MARK: - Filter Logic
    private func applyFilter(index: Int) {
        let filter = filters[index]
        
        if filter == "All" {
            
            filteredNowShowingMovies = allNowShowingMovies
            filteredComingSoonMovies = allComingSoonMovies
        } else {
            // 필터링 로직: 예시로 장르에 포함된 단어로 필터링
            filteredNowShowingMovies = allNowShowingMovies.filter { $0.genres.contains(filter) }
            filteredComingSoonMovies = allComingSoonMovies.filter { $0.genres.contains(filter) }
        }
        
        // 섹션 1과 섹션 2만 리로드
        print("[HomeViewController] Filter Selected: \(filter)")
        collectionView?.reloadSections(IndexSet(integer: 1))
        collectionView?.reloadSections(IndexSet(integer: 2))
    }
    
    // MARK: - Compositional Layout
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
            case 0: return self.createFilterSectionLayout()
            case 1: return self.createNowShowingSectionLayout()
            case 2: return self.createComingSoonSectionLayout()
            default: return nil
            }
        }
    }
    
    private func createFilterSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .absolute(32))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .absolute(32))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(32))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func createNowShowingSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(210), heightDimension: .absolute(368))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(210), heightDimension: .absolute(368))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 0)
        
        return section
    }
    
    private func createComingSoonSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(95), heightDimension: .absolute(145))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(95), heightDimension: .absolute(145))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 0)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(26))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return filters.count
        case 1: return allNowShowingMovies.count
        case 2: return allComingSoonMovies.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DYFilterCell.identifier, for: indexPath) as! DYFilterCell
            cell.configure(with: filters[indexPath.item])
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DYMovieCell.identifier, for: indexPath) as! DYMovieCell
            cell.configure(with: allNowShowingMovies[indexPath.item])
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DYPosterCell.identifier, for: indexPath) as! DYPosterCell
            cell.configure(with: allComingSoonMovies[indexPath.item])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    // Header 설정
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DYHeaderView.identifier, for: indexPath) as! DYHeaderView
        
        switch indexPath.section {
        case 0:
            header.configure(with: "Now Showing", andSize: 27)
        case 2:
            header.configure(with: "Coming Soon", andSize: 22)
        default:
            break
        }
        
        return header
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? DYFilterCell
        cell?.isSelected = true
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? DYFilterCell
        cell?.isSelected = false
    }
}
