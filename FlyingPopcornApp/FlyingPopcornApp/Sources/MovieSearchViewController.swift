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
    
    private var movies: [DummyMovieData] = [] // 전체 데이터
    private var searchedMovies: [DummyMovieData] = [] // 검색 결과 데이터
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = movieSearchView
        movieSearchView.delegate = self
        
        configureUI()
        configureData()
    }
    
    private func configureUI() {
        title = "Search" // 네비게이션 타이틀 추가
        view.backgroundColor = UIColor(named: "greyLight1")
        
        // Search Controller 설정
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func configureData() {
        movies = [
            DummyMovieData(title: "Coco", genre: "Animation", posterImageName: "MoviePoster1"),
            DummyMovieData(title: "Joker", genre: "Thriller", posterImageName: "MoviePoster2"),
            DummyMovieData(title: "The Avengers", genre: "Action", posterImageName: "MoviePoster3"),
        ]
        searchedMovies = movies // 초기 상태에선 전체 데이터 표시
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
            movie.title.lowercased().contains(searchText.lowercased()) ||
            movie.genre.lowercased().contains(searchText.lowercased())
        }
        
        movieSearchView.reloadCollectionView()
    }
    
}

extension MovieSearchViewController: MovieSearchViewDelegate {
    func numberOfItems() -> Int {
        return searchedMovies.count
    }
    
    func movie(at index: Int) -> DummyMovieData {
        return searchedMovies[index]
    }
}
