//
//  MyPageViewController.swift
//  FlyingPopcornApp
//
//  Created by seohuibaek on 12/17/24.
//

import UIKit

final class MyPageViewController: UIViewController {
    //private let userInformationView = UserInformationView()
    private let myPageView = MyPageView()
    
    private var movies: [DummyMovieData] = [] // 전체 데이터

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = myPageView
        view.backgroundColor = UIColor(named: "fp100")
        
        myPageView.delegate = self
        
        configureUI()
        configureData()
        // loadUserData() 싱글톤?
    }
    
    private func configureUI() {
        navigationItem.title = "MyPage"
    }
}

extension MyPageViewController: MyPageViewDelegate {
    private func configureData() {
        movies = [
            DummyMovieData(title: "Coco", genre: "Animation", posterImageName: "MoviePoster1", runTime: "2024년 12월 23일", schedule: "13:30"),
            DummyMovieData(title: "Joker", genre: "Thriller", posterImageName: "MoviePoster2", runTime: "2024년 12월 30일", schedule: "14:30"),
            DummyMovieData(title: "The Avengers", genre: "Action", posterImageName: "MoviePoster3", runTime: "2024년 12월 30일", schedule: "15:30"),
        ]
    }
    
    func numberOfItems() -> Int {
        return movies.count
    }
    
    func movie(at index: Int) -> DummyMovieData {
        return movies[index]
    }
}

// 싱글톤?
//extension MyPageViewController {
//    private func loadUserData() {
//        if let userData = UserDefaultsHelper.shared.getUserData() {
//            myPageView.userInformationView.updateUserInfo(with: userData)
//        }
//    }
//}
