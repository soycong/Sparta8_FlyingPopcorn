//
//  HomeViewController.swift
//  FlyingPopcornApp
//
//  Created by t0000-m0112 on 2024-12-16.
//

import UIKit

final class HomeViewController: UIViewController {
    private let movieNetwork: MovieNetwork
    
    init(movieNetwork: MovieNetwork) {
        self.movieNetwork = movieNetwork
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    private var filters: [String] {
        return ["All"] + Movie.genreMap.values.sorted()
    }
    private var allNowShowingMovies: [Movie] = []
    private var allComingSoonMovies: [Movie] = []
    private var filteredNowShowingMovies: [Movie] = []
    private var filteredComingSoonMovies: [Movie] = []
    
    private let homeView = HomeView()
    
    // MARK: - LifeCycle
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchMoviesData()
        applyFilter(index: 0)
    }
    
    // MARK: - Setup
    private func setupCollectionView() {
        let collectionView = homeView.collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(DYFilterCell.self, forCellWithReuseIdentifier: DYFilterCell.identifier)
        collectionView.register(DYMovieCell.self, forCellWithReuseIdentifier: DYMovieCell.identifier)
        collectionView.register(DYPosterCell.self, forCellWithReuseIdentifier: DYPosterCell.identifier)
        collectionView.register(DYHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DYHeaderView.identifier)
        
        collectionView.collectionViewLayout = createCompositionalLayout()
    }
    
    // MARK: - Fetch Movies Data
    private func fetchMoviesData() {
        let group = DispatchGroup()
        
        // Now Playing Movies
        group.enter()
        movieNetwork.getNowPlayingList { [weak self] result in
            defer { group.leave() }
            switch result {
            case .success(let movieListModel):
                self?.allNowShowingMovies = movieListModel.results
                self?.filteredNowShowingMovies = movieListModel.results
            case .failure(let error):
                print("Failed to fetch now playing movies: \(error)")
            }
        }
        
        // Popular Movies
        group.enter()
        movieNetwork.getPopularList { [weak self] result in
            defer { group.leave() }
            switch result {
            case .success(let movieListModel):
                self?.allComingSoonMovies = movieListModel.results
                self?.filteredComingSoonMovies = movieListModel.results
            case .failure(let error):
                print("Failed to fetch popular movies: \(error)")
            }
        }
        
        // 모든 데이터가 로드된 후 한 번에 CollectionView 업데이트
        group.notify(queue: .main) { [weak self] in
            self?.homeView.collectionView.reloadData()
        }
    }
    
    // MARK: - Filter Logic
    private func applyFilter(index: Int) {
        let filter = filters[index]
        if filter == "All" {
            filteredNowShowingMovies = allNowShowingMovies
            filteredComingSoonMovies = allComingSoonMovies
        } else {
            filteredNowShowingMovies = allNowShowingMovies.filter { $0.genres.contains(filter) }
            filteredComingSoonMovies = allComingSoonMovies.filter { $0.genres.contains(filter) }
        }
        
        print("[HomeViewController] Filter Selected: \(filter)")
        
        // 전체 CollectionView를 한 번에 리로드
        homeView.collectionView.reloadData()
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
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(26))
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

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return filters.count
        case 1: return filteredNowShowingMovies.count
        case 2: return filteredComingSoonMovies.count
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
            cell.configure(with: filteredNowShowingMovies[indexPath.item])
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DYPosterCell.identifier, for: indexPath) as! DYPosterCell
            cell.configure(with: filteredComingSoonMovies[indexPath.item])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DYHeaderView.identifier, for: indexPath) as! DYHeaderView
        
        switch indexPath.section {
        case 0:
            header.configure(with: "Now Showing", andSize: 27)
        case 2:
            header.configure(with: "Popular Picks", andSize: 22)
        default:
            break
        }
        
        return header
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let selectedMovie = filteredNowShowingMovies[indexPath.item]
            let detailVC = MovieDetailViewController(movieNetwork: movieNetwork, movieID: selectedMovie.id)
            navigationController?.pushViewController(detailVC, animated: true)
        } else if indexPath.section == 2 {
            let selectedMovie = filteredComingSoonMovies[indexPath.item]
            let detailVC = MovieDetailViewController(movieNetwork: movieNetwork, movieID: selectedMovie.id)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
