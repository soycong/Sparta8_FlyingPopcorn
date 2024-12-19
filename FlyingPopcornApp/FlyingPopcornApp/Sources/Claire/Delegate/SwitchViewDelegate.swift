//
//  SwitchViewDelegate.swift
//  FlyingPopcornApp
//
//  Created by Claire on 12/19/24.
//

protocol SigninViewDelegate: AnyObject {
    func didTapSignupButton()
    func moveToMain()
}

protocol SignupViewDelegate: AnyObject {
    func didTapSigninButton()
}
