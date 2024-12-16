//
//  MovieDetailViewController.swift
//  FlyingPopcornApp
//
//  Created by t2023-m0019 on 12/15/24.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    private let movieDetailView = MovieDetailView()
    
    override func loadView() {
        self.view = movieDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookingButton()
        
        let movie = SYMovie(
            adult: false,
            id: 123,
            genreIDS: [28, 35],
            genres: ["Action", "Comedy"],
            title: "Movie Title",
            overview: "This is a movie overview.",
            posterURL: "https://example.com/poster.jpg",
            vote: "8.2 (200)",
            voteAverage: 6.3,
            releaseDate: "2023-12-16"
        )
        movieDetailView.configureView(with: movie)
    }
}


extension MovieDetailViewController {
    func bookingButton() {
        movieDetailView.bookingButton.addTarget(self, action: #selector(bookPushView), for: .touchUpInside)
    }
    
    @objc func bookPushView() {
        print("예매하기버튼 탭")
    }
}
