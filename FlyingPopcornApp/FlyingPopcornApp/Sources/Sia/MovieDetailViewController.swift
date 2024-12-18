//
//  MovieDetailViewController.swift
//  FlyingPopcornApp
//
//  Created by t2023-m0019 on 12/15/24.
//

import UIKit

protocol MovieDetailDelegate: AnyObject {
    // 예매하기 버튼 탭시 movieId 전달
    func didTapBokkingButton(movieId: Int)
}

final class MovieDetailViewController: UIViewController {
    private let movieDetailView = MovieDetailView()
    private let movieNetwork: MovieNetwork
    private var movieID: Int // 영화 ID
    
    weak var delegate: MovieDetailDelegate?
    
    init(movieNetwork: MovieNetwork, movieID: Int) {
        self.movieNetwork = movieNetwork
        self.movieID = movieID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = movieDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 네트워크 상태 확인
        bookingButton()
        fetchMovieDetail()
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

// MARK: - Network 요청
private extension MovieDetailViewController {
    // 영화 상세 정보 네트워크 요청
    func fetchMovieDetail() {
        movieNetwork.getMovieDetail(movieID: movieID) { [weak self] result in
            switch result {
            case .success(let movie):
                self?.movieDetailView.configureView(with: movie)
            case .failure(let error):
                print("Failed to fetch movie detail: \(error)")
            }
        }
    }
    
    func bookingButton() {
        movieDetailView.bookingButton.addTarget(self, action: #selector(bookPushView), for: .touchUpInside)
    }
    
    @objc func bookPushView() {
        print("예매하기버튼 탭")
        
        // TODO: - 로그인 여부 체크
        
        // 로그인 완료 후 예매하기 버튼 탭시
        delegate?.didTapBokkingButton(movieId: movieID)
    }
}
