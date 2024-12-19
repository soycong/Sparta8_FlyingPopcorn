//
//  BottomTabbarViewController.swift
//  FlyingPopcornApp
//
//  Created by t2023-m0019 on 12/18/24.
//

import UIKit

final class BottomTabbarViewController: UITabBarController {
    private let movieNetwork: MovieNetwork
    
    init(movieNetwork: MovieNetwork) {
        self.movieNetwork = movieNetwork
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupTabBarItem()
    }
}

private extension BottomTabbarViewController {
    func setupTabBar() {
        // iOS 13 이상부터 탭바 스타일 설정
        let appearanceTabbar = UITabBarAppearance()
        appearanceTabbar.configureWithOpaqueBackground()
        appearanceTabbar.backgroundColor = .white
        appearanceTabbar.shadowColor = UIColor.clear // 탭바 상단 line 안보이게 설정

        // 탭바 아이템 텍스트 색상 설정
        appearanceTabbar.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.gray
        ]
        appearanceTabbar.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.fpRed
        ]
        
        // 탭바 아이콘 색상 설정
        appearanceTabbar.stackedLayoutAppearance.selected.iconColor = UIColor.fpRed
        
        tabBar.standardAppearance = appearanceTabbar
        tabBar.scrollEdgeAppearance = appearanceTabbar
    }
    
    //각각 네비게이션컨트롤러 지정
    func setupTabBarItem() {
        let homeVC = HomeViewController(movieNetwork: movieNetwork)
        let homeNavVC = UINavigationController(rootViewController: homeVC)
        homeVC.tabBarItem = UITabBarItem(title: "Home",
                                            image: UIImage(named: "icHomeOff"),
                                            selectedImage: UIImage(named: "icHomeOff"))
        
        let movieSearchVC = MovieSearchViewController(movieNetwork: movieNetwork)
        let searchNavVC = UINavigationController(rootViewController: movieSearchVC)
        searchNavVC.tabBarItem = UITabBarItem(title: "Search",
                                              image: UIImage(named: "icSearchOff"),
                                              selectedImage: UIImage(named: "icSearchOff"))
        
        let myPageVC = MyPageViewController()
        let myPageNavVC = UINavigationController(rootViewController: myPageVC)
        myPageNavVC.tabBarItem = UITabBarItem(title: "My",
                                              image: UIImage(named: "icMyOff"),
                                              selectedImage: UIImage(named: "icMyOff"))
        
        viewControllers = [homeNavVC, searchNavVC, myPageNavVC]
    }
}
