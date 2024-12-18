//
//  BottomTabbarViewController.swift
//  FlyingPopcornApp
//
//  Created by t2023-m0019 on 12/18/24.
//

import UIKit

final class BottomTabbarViewController: UITabBarController {
    
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
            .foregroundColor: UIColor(named: "FPRed")!
        ]
        
        // 탭바 아이콘 색상 설정
        appearanceTabbar.stackedLayoutAppearance.selected.iconColor = UIColor(named: "FPRed")
        
        tabBar.standardAppearance = appearanceTabbar
        tabBar.scrollEdgeAppearance = appearanceTabbar
    }
    
    func setupTabBarItem() {
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home",
                                         image: UIImage(named: "icHomeOff"),
                                         selectedImage: UIImage(named: "icHomeOff"))
        
        let movieSearchVC = MovieSearchViewController()
        movieSearchVC.tabBarItem = UITabBarItem(title: "Search",
                                                image: UIImage(named: "icSearchOff"),
                                                selectedImage: UIImage(named: "icSearchOff"))
        
        let myPageVC = MyPageViewController()
        myPageVC.tabBarItem = UITabBarItem(title: "My",
                                           image: UIImage(named: "icMyOff"),
                                           selectedImage: UIImage(named: "icMyOff"))
        
        viewControllers = [homeVC, movieSearchVC, myPageVC]
    }
}
