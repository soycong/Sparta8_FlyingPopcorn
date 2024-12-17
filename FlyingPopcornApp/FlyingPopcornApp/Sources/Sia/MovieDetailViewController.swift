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
            title: "WALL-E",
            overview: "길을 잃고 혼자가 된 새끼 사자 무파사는 광활한 야생을 떠돌던 중 왕의 혈통이자 예정된 후계자 타카와 우연히 만나게 된다. 마치 친형제처럼 끈끈한 우애를 나누며 함께 자란 무파사와 타카는 운명을 개척하기 위해 거대한 여정을 함께 떠난다. 한 치 앞을 알 수 없는 적들의 위협 속에서 두 형제의 끈끈했던 유대에 금이 가기 시작하고 예상치 못한 위기까지 맞닥뜨리게 되는데…길을 잃고 혼자가 된 새끼 사자 무파사는 광활한 야생을 떠돌던 중 왕의 혈통이자 예정된 후계자 타카와 우연히 만나게 된다. 마치 친형제처럼 끈끈한 우애를 나누며 함께 자란 무파사와 타카는 운명을 개척하기 위해 거대한 여정을 함께 떠난다. 한 치 앞을 알 수 없는 적들의 위협 속에서 두 형제의 끈끈했던 유대에 금이 가기 시작하고 예상치 못한 위기까지 맞닥뜨리게 되는데…길을 잃고 혼자가 된 새끼 사자 무파사는 광활한 야생을 떠돌던 중 왕의 혈통이자 예정된 후계자 타카와 우연히 만나게 된다. 마치 친형제처럼 끈끈한 우애를 나누며 함께 자란 무파사와 타카는 운명을 개척하기 위해 거대한 여정을 함께 떠난다. 한 치 앞을 알 수 없는 적들의 위협 속에서 두 형제의 끈끈했던 유대에 금이 가기 시작하고 예상치 못한 위기까지 맞닥뜨리게 되는데…길을 잃고 혼자가 된 새끼 사자 무파사는 광활한 야생을 떠돌던 중 왕의 혈통이자 예정된 후계자 타카와 우연히 만나게 된다. 마치 친형제처럼 끈끈한 우애를 나누며 함께 자란 무파사와 타카는 운명을 개척하기 위해 거대한 여정을 함께 떠난다.길을 잃고 혼자가 된 새끼 사자 무파사는 광활한 야생을 떠돌던 중 왕의 혈통이자 예정된 후계자 타카와 우연히 만나게 된다. 마치 친형제처럼 끈끈한 우애를 나누며 함께 자란 무파사와 타카는 운명을 개척하기 위해 거대한 여정을 함께 떠난다.",
            posterURL: "https://example.com/poster.jpg",
            vote: "8.2 (200)",
            voteAverage: 6.3,
            releaseDate: "2023-12-16",
            runtime: 91
        )
        movieDetailView.configureView(with: movie)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
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
