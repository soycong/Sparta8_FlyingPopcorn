//
//  SignupView.swift
//  Sai
//
//  Created by CHYUN on 12/17/24.
//
import UIKit

// 가입 화면
final class SignupView: UIView {
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let nameStackView = UIStackView()
    let FamilyNameTextField = StrokeTextField(hintText: "성")
    let nameTextField = StrokeTextField(hintText: "이름")
    let emailTextField = StrokeEmailField(hintText: "이메일")
    let passwordTextField = StrokePasswordField(hintText: "비밀번호")
    let signInButton = MainSolidButton(title: "가입하기")
    lazy var signSwitchLabel = SignSwitchLabel(
        question: "이미 계정이 있나요?",
        buttonTitle: "로그인하기",
        buttonEvent: switchToSignin,
        frame: frame
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        [titleLabel, subTitleLabel, nameStackView, emailTextField, passwordTextField, signInButton, signSwitchLabel].forEach { view in
            addSubview(view)
        }
        
        [FamilyNameTextField, nameTextField].forEach { view in
            nameStackView.addArrangedSubview(view)
        }
        
        nameStackView.axis = .horizontal
        nameStackView.spacing = 16
        nameStackView.distribution = .fillEqually
        
        titleLabel.text = "Sign Up"
        titleLabel.font = .systemFont(ofSize: 30, weight: .bold)
        
        subTitleLabel.text = "You have been missed"
        subTitleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        subTitleLabel.textColor = UIColor.systemGray4
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(40)
            make.leading.equalTo(safeAreaLayoutGuide).offset(24)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-24)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        nameStackView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(32)
            make.leading.trailing.equalTo(titleLabel)
            make.height.equalTo(52)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nameStackView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(titleLabel)
            make.height.equalTo(52)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.leading.trailing.height.equalTo(emailTextField)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(80)
            make.leading.trailing.height.equalTo(emailTextField)
        }
        
        signSwitchLabel.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-60)
            make.leading.trailing.height.equalTo(emailTextField)
        }
    }
    
    @objc private func switchToSignin() {
        
    }
}
