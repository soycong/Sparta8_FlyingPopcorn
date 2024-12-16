//
//  MovieSearchViewController.swift
//  FlyingPopcornApp
//
//  Created by seohuibaek on 12/16/24.
//
import UIKit

final class MovieSearchViewController: UIViewController {
    private let movieSearchView = MovieSearchView()
    private let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = movieSearchView
        
        configureUI()
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
}

extension MovieSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}
