//
//  Untitled.swift
//  FlyingPopcornApp
//
//  Created by Claire on 12/18/24.
//

import UIKit
import SnapKit

class SigninViewController: UIViewController, SigninViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        let signinView = SigninView()
        view.addSubview(signinView)
        
        signinView.delegate = self

        let alert = { [weak self] (title: String, message: String, completion: (() -> Void)?) in
            let alertController = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )
            let alertAction = UIAlertAction(title: "확인", style: .default) { _ in
                completion?()
            }
            alertController.addAction(alertAction)
            self?.present(alertController, animated: true)
        }
        
        signinView.showAlert = alert
        signinView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }
    
    func didTapSignupButton() {
        let signupViewController = SignupViewController()
        signupViewController.modalPresentationStyle = .fullScreen
        present(signupViewController, animated: true)
    }
    
    func moveToMain() {
        
        print(UserData.loginedUser)
        
        let movieNetwork = MovieNetwork(network: Network<MovieListModel>(endPoint: "https://api.themoviedb.org/3"))

        let tabBarViewController = BottomTabbarViewController(movieNetwork: movieNetwork)
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = tabBarViewController
        }
    }

}

// 키보드 숨기기
extension SigninViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(SigninViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
