//
//  Untitled.swift
//  FlyingPopcornApp
//
//  Created by Claire on 12/18/24.
//

import UIKit
import SnapKit

class SignupViewController: UIViewController, SignupViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        let signupView = SignupView()
        view.addSubview(signupView)
        
        signupView.delegate = self
        
        let alert = { [weak self] title, message in
            let alertController = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )
            let alertAction = UIAlertAction(title: "확인", style: .default)
            alertController.addAction(alertAction)
            self?.present(alertController, animated: true)
        }

        signupView.showAlert = alert
        signupView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func didTapSigninButton() {
        dismiss(animated: true)
    }
}

// 키보드 숨기기
extension SignupViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignupViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
