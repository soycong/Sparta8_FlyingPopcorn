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
    
    // 영화 상세 정보 네트워크 요청
    func fetchMovieDetail() {
        print("Fetching details for movie ID: \(movie.id)")
        movieNetwork.getMovieDetail(movieID: movie.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movieDetail):
                    print("Fetched movie details: \(movieDetail)")
                    self?.movie = movieDetail
                    
                    if let runtime = movieDetail.runtime {
                        self?.movieDetailView.runtimeLabel.text = "Runtime: \(runtime) min"
                    } else {
                        self?.movieDetailView.runtimeLabel.text = "Runtime: N/A"
                    }
                    
                    self?.movieDetailView.configureView(with: movieDetail)
                    
                case .failure(let error):
                    print("Failed to fetch movie detail: \(error.localizedDescription)")
                    self?.movieDetailView.runtimeLabel.text = "Runtime: N/A"
                }
            }
        }
    }
    
    func bookingButton() {
        movieDetailView.bookingButton.addTarget(self, action: #selector(bookPushView), for: .touchUpInside)
    }
    
    @objc func bookPushView() {        
        // TODO: - 로그인 여부 체크
        //let userDefaultsHelper = UserDefaultsHelper()
        //let userDictionary = userDefaultsHelper.getUserDictionary()
        
        // 데이터가 없으면 로그인 화면으로 이동
//        if userDictionary.isEmpty {
//            let signUpVC = SignupViewController()
//            let signUpNavController = UINavigationController(rootViewController: signUpVC)
//            signUpNavController.modalPresentationStyle = .fullScreen
//            
//            // 현재 윈도우 가져와서 루트 변경
//            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? UIWindowSceneDelegate,
//               let window = sceneDelegate.window {
//                window?.rootViewController = signUpNavController
//                window?.makeKeyAndVisible()
//            }
//        } else {
            // 데이터가 있으면 예매 화면으로 이동
            let bookingVC = BookingViewController(movie: movie) // 생성자 주입
            navigationController?.pushViewController(bookingVC, animated: true)
//        }
    }
}
