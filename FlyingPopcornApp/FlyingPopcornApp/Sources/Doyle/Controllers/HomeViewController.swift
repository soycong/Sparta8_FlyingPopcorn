//
//  HomeViewController.swift
//  FlyingPopcornApp
//
//  Created by t0000-m0112 on 2024-12-16.
//

import UIKit

final class HomeViewController: UIViewController {
    private let movieNetwork: MovieNetwork
    
    private var selectedFilterIndex: Int = 0 {
        willSet {
            applyFilter(index: newValue)
        }
    }
    
    init(movieNetwork: MovieNetwork) {
        self.movieNetwork = movieNetwork
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    private var filters: [String] {
        return ["전체"] + Movie.genreMap.values.sorted()
    }
    private var allNowShowingMovies: [Movie] = []
    private var allPopularMovies: [Movie] = []
    private var filteredNowShowingMovies: [Movie] = []
    private var filteredPopularMovies: [Movie] = []
    
    private let homeView = HomeView()
    
    // MARK: - LifeCycle
    override func loadView() {
//        homeView.searchButton.addTarget(self, action: #selector(goToSearchPage), for: .touchUpInside)
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchMoviesData()
        applyFilter(index: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 이 화면에 들어올 때 Navigation Bar 숨기기
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 이 화면을 떠날 때 Navigation Bar 다시 보이게 하기
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Setup
    private func setupCollectionView() {
        let collectionView = homeView.collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = false
        
        collectionView.register(HomeFilterCell.self, forCellWithReuseIdentifier: HomeFilterCell.identifier)
        collectionView.register(HomeMovieCell.self, forCellWithReuseIdentifier: HomeMovieCell.identifier)
        collectionView.register(HomePosterCell.self, forCellWithReuseIdentifier: HomePosterCell.identifier)
        collectionView.register(HomeHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeHeaderView.identifier)
        
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
                self?.allPopularMovies = movieListModel.results
                self?.filteredPopularMovies = movieListModel.results
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
        if filter == "전체" {
            filteredNowShowingMovies = allNowShowingMovies
            filteredPopularMovies = allPopularMovies
        } else {
            filteredNowShowingMovies = allNowShowingMovies.filter { $0.genres.contains(filter) }
            filteredPopularMovies = allPopularMovies.filter { $0.genres.contains(filter) }
        }
        
        print("[HomeViewController] Filter Selected: \(filter)")
        
        // 전체 CollectionView를 한 번에 리로드
        homeView.collectionView.reloadData()
    }
    
    // MARK: - Button Action for Search Bar
    @objc func goToSearchPage() {
        if let tabBar = self.tabBarController {
            tabBar.selectedIndex = 1 // 검색 페이지로 이동
        }
    }
}

// MARK: - CollectionView: Compositional Layout
extension HomeViewController {
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
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 0)
        
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
        case 2: return filteredPopularMovies.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeFilterCell.identifier, for: indexPath) as! HomeFilterCell
            cell.configure(with: filters[indexPath.item])
            cell.updateSelectionState(isSelected: indexPath.item == selectedFilterIndex)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMovieCell.identifier, for: indexPath) as! HomeMovieCell
            cell.configure(with: filteredNowShowingMovies[indexPath.item])
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePosterCell.identifier, for: indexPath) as! HomePosterCell
            cell.configure(with: filteredPopularMovies[indexPath.item])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeHeaderView.identifier, for: indexPath) as! HomeHeaderView
        
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

// MARK: - UICOllectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0: // Filter Section
            let previousIndex = selectedFilterIndex
            selectedFilterIndex = indexPath.item
            collectionView.reloadItems(at: [IndexPath(item: previousIndex, section: 0), IndexPath(item: selectedFilterIndex, section: 0)])
        case 1: // Now Showing Section
            let selectedMovie = filteredNowShowingMovies[indexPath.item]
            print("[HomeViewController] Selected Now Showing Movie: \(selectedMovie.title)")
            
            // MovieDetailViewController로 영화 데이터 전달
            let detailVC = MovieDetailViewController(movieNetwork: movieNetwork, movie: selectedMovie) // 생성자 주입
            detailVC.hidesBottomBarWhenPushed = true // 탭바 숨기기 설정
            navigationController?.pushViewController(detailVC, animated: true)
        case 2: // Coming Soon Section
            let selectedMovie = filteredPopularMovies[indexPath.item]
            print("[HomeViewController] Selected Popular Movie: \(selectedMovie.title)")
            
            // MovieDetailViewController로 영화 데이터 전달
            let detailVC = MovieDetailViewController(movieNetwork: movieNetwork, movie: selectedMovie) // 생성자 주입
            detailVC.hidesBottomBarWhenPushed = true // 탭바 숨기기 설정
            navigationController?.pushViewController(detailVC, animated: true)
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let cell = collectionView.cellForItem(at: indexPath) as? HomeFilterCell
            cell?.updateSelectionState(isSelected: false)
        }
    }
}
