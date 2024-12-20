//
//  SceneDelegate.swift
//  FlyingPopcornApp
//
//  Created by t0000-m0112 on 2024-12-13.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        // MovieNetwork 초기화
        let movieNetwork = MovieNetwork(network: Network<MovieListModel>(endPoint: "https://api.themoviedb.org/3"))

        // 저장된 유저 체크
        if let userEmail = UserDefaultsHelper.shared.getCurrentUser() {
            // 저장된 사용자 정보로 UserData 업데이트
            UserDefaultsHelper.shared.loadUserData(email: userEmail)
            
            // 데이터 체크
            print("family-name: \(String(describing: UserData.shared.familyName)), name: \(String(describing: UserData.shared.name)), email: \(String(describing: UserData.shared.email)), tickets: \(UserData.shared.tickets)")
            
            // 자동 로그인 -> 메인 화면으로 이동
            let tabBarViewController = BottomTabbarViewController(movieNetwork: movieNetwork)
            window?.rootViewController = tabBarViewController
        } else {
            // 마스터 계정이 없는 경우에만 생성
            if !UserDefaultsHelper.shared.checkUserData(email: UserDefaultsHelper.masterEmail, password: UserDefaultsHelper.masterPassword).response {
                // 마스터 유저 모델 생성
                UserData.shared.updateUserInfo(
                    familyName: "none",
                    name: "master",
                    email: UserDefaultsHelper.masterEmail,
                    password: UserDefaultsHelper.masterPassword,
                    tickets: []
                )
                // 마스터 계정 저장후 싱글톤 초기화
                UserDefaultsHelper.shared.saveUserData(user: UserData.shared)
                UserData.shared.clearUserData()
            }
            
            // 로그인된 사용자가 없음 -> 로그인 화면으로 이동
            let signinViewController = SigninViewController()
            let navigationController = UINavigationController(rootViewController: signinViewController)
            window?.rootViewController = navigationController
        }
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        //        (UIApplication.shared.delegate as? AppDelegate)?.saveContext() // s
    }
}
