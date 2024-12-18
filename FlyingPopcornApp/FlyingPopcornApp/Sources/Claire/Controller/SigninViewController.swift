//
//  Untitled.swift
//  FlyingPopcornApp
//
//  Created by Claire on 12/18/24.
//

import UIKit
import SnapKit

class SigninViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()

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
        
        let signinView = SigninView()
        view.addSubview(signinView)
        signinView.showAlert = alert
        signinView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
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
