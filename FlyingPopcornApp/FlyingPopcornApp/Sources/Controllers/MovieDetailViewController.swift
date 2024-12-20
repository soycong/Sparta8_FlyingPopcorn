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
        // UserData 싱글톤 가져오기
        let userData = UserData.shared
        
        // 로그인 여부 체크
        if userData.email == nil {
            // 데이터가 없으면 알림창 띄우기
            let alert = UIAlertController(title: "로그인이 필요합니다",
                                          message: "로그인하시겠습니까?",
                                          preferredStyle: .alert)
            
            // "확인" 버튼 (로그인 화면으로 이동)
            let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
                let signInVC = SigninViewController()
                let signInNavController = UINavigationController(rootViewController: signInVC)
                signInNavController.modalPresentationStyle = .fullScreen
                
                // 현재 윈도우 가져와서 루트 변경
                if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? UIWindowSceneDelegate,
                   let window = sceneDelegate.window {
                    window?.rootViewController = signInNavController
                    window?.makeKeyAndVisible()
                }
            }
            
            // 취소 버튼 (디테일 화면 스테이..)
            let cancelAction = UIAlertAction(title: "취소", style: .destructive)
            
            // 알림창에 액션 추가
            alert.addAction(confirmAction)
            alert.addAction(cancelAction)
            
            // 현재 화면에서 알림창 표시
            self.present(alert, animated: true, completion: nil)
            
        } else {
            // 데이터가 있으면 예매 화면으로 이동
            let bookingVC = BookingViewController(movie: movie) // 생성자 주입
            navigationController?.pushViewController(bookingVC, animated: true)
        }
    }
}
