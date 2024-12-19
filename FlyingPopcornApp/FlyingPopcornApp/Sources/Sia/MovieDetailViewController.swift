//
//  MovieDetailViewController.swift
//  FlyingPopcornApp
//
//  Created by t2023-m0019 on 12/15/24.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    private let movieDetailView = MovieDetailView()
    private let movieNetwork: MovieNetwork
    private var movie: Movie // 영화
    
    weak var delegate: MovieDetailDelegate?
    
    init(movieNetwork: MovieNetwork, movie: Movie) {
        self.movieNetwork = movieNetwork
        self.movie = movie
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
        //checkNetworkAndFetchMovieDetail()
        setupNavigationBar()
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
     func setupNavigationBar() {
         let appearance = UINavigationBarAppearance()
         appearance.configureWithOpaqueBackground()
         appearance.shadowColor = nil
         appearance.shadowImage = UIImage()
         
         navigationController?.navigationBar.standardAppearance = appearance
         navigationController?.navigationBar.scrollEdgeAppearance = appearance
         
         let naviLeftItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(handleBackButton))
         naviLeftItem.tintColor = .fp00
         navigationItem.leftBarButtonItem = naviLeftItem
     }
    
    // 네비게이션 스택에서 이전 화면으로 이동
    @objc func handleBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func checkNetworkAndFetchMovieDetail() {
        if NetworkMonitor.shared.isConnected {
            fetchMovieDetail()
        } else {
            showAlert(message: "네트워크가 연결되지 않았습니다. 인터넷 연결을 확인해주세요.")
        }
    }
    
    // 영화 상세 정보 네트워크 요청
    func fetchMovieDetail() {
        movieNetwork.getMovieDetail(movieID: movie.id) { [weak self] result in
            switch result {
            case .success(let movie):
                self?.movie = movie
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
        let bookingVC = BookingViewController(movie: movie) // 생성자 주입
        navigationController?.pushViewController(bookingVC, animated: true)
    }
}

private extension MovieDetailViewController {
    // 네트워크 연결이 없을 때 alert
    func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
