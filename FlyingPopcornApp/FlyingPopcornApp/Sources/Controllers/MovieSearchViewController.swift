//
//  MovieSearchViewController.swift
//  FlyingPopcornApp
//
//  Created by seohuibaek on 12/16/24.
//

import UIKit

final class MovieSearchViewController: UIViewController {
    private let movieSearchView = MovieSearchCollectionView()
    private let searchController = UISearchController()
    
    private var movies: [Movie] = [] // 전체 데이터
    private var searchedMovies: [Movie] = [] // 검색 결과 데이터
    
    private var movieNetwork: MovieNetwork?
    
    // MARK: Initializer
    init(movieNetwork: MovieNetwork) {
        self.movieNetwork = movieNetwork
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = movieSearchView
        movieSearchView.delegate = self
        
        configureUI()
        fetchMovies()
    }
    
    private func configureUI() {
        title = "Search"
        view.backgroundColor = .fp00
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "영화 제목을 입력해주세요."
        searchController.searchBar.tintColor = .fpRed
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // API에서 영화 목록 가져오기
    private func fetchMovies() {
        movieNetwork?.getNowPlayingList { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movieList):
                    self?.movies = movieList.results
                    self?.searchedMovies = movieList.results
                    self?.movieSearchView.reloadCollectionView()
                case .failure(let error):
                    print("영화 목록 로딩 실패: \(error)")
                    print("에러 세부 정보: \(error.localizedDescription)")
                }
            }
        }
    }
}

extension MovieSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            searchedMovies = movies // 검색어가 없으면 전체 데이터 표시
            movieSearchView.reloadCollectionView()
            return
        }
        
        searchedMovies = movies.filter { movie in
            movie.title.lowercased().contains(searchText.lowercased())
        }
        
        movieSearchView.reloadCollectionView()
    }
    
}

extension MovieSearchViewController: MovieSearchViewDelegate {
    func numberOfItems() -> Int {
        return searchedMovies.count
    }
    
    func movie(at index: Int) -> Movie {
        return searchedMovies[index]
    }
    
    func didSelectMovie(at index: Int) {
        let selectedMovie = searchedMovies[index]

        if let movieNetwork = self.movieNetwork {
            let movieDetailVC = MovieDetailViewController(movieNetwork: movieNetwork, movie: selectedMovie)
            movieDetailVC.hidesBottomBarWhenPushed = true // 탭바 숨기기 설정
            navigationController?.pushViewController(movieDetailVC, animated: true)
        } else {
            print("Error: MovieNetwork is nil")
        }
    }
}
