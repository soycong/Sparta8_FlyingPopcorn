//
//  MovieSearchViewController.swift
//  FlyingPopcornApp
//
//  Created by seohuibaek on 12/16/24.
//
import UIKit

final class MovieSearchViewController: UIViewController, UISearchResultsUpdating {
    private let searchController = UISearchController(searchResultsController: nil)
    
    private func configureUI() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        <#code#>
    }
}
