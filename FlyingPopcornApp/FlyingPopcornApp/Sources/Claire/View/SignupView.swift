//
//  SignupView.swift
//  Sai
//
//  Created by CHYUN on 12/17/24.
//
import UIKit

// 가입 화면
final class SignupView: UIView {
    weak var delegate: SignupViewDelegate?
    
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let nameStackView = UIStackView()
    private let familyNameTextField = StrokeTextField(hintText: "성")
    private let nameTextField = StrokeTextField(hintText: "이름")
    private let emailTextField = StrokeEmailField(hintText: "이메일")
    private let passwordTextField = StrokePasswordField(hintText: "비밀번호")
    private let signupButton = MainSolidButton(title: "가입하기")
    lazy var signSwitchLabel = SignSwitchLabel(
        question: "이미 계정이 있나요?",
        buttonTitle: "로그인하기",
        buttonEvent: switchToSignin,
        frame: frame
    )
    
    // 입력정보 부족시 띄울 알러트
    var showAlert: ((String, String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        signupButton.addTarget(self, action: #selector(saveUser), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        [titleLabel, subTitleLabel, nameStackView, emailTextField, passwordTextField, signupButton, signSwitchLabel].forEach { view in
            addSubview(view)
        }
        
        [familyNameTextField, nameTextField].forEach { view in
            nameStackView.addArrangedSubview(view)
        }
        
        nameStackView.axis = .horizontal
        nameStackView.spacing = 16
        nameStackView.distribution = .fillEqually
        
        titleLabel.text = "회원가입"
        titleLabel.font = .systemFont(ofSize: 30, weight: .bold)
        
        subTitleLabel.text = "가입을 위한 정보를 입력해주세요."
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
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(80)
            make.leading.trailing.height.equalTo(emailTextField)
        }
        
        signSwitchLabel.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-60)
            make.centerX.equalTo(signupButton.snp.centerX)
        }
    }
    
    private func checkIsEmpty(user: UserData) -> Bool {
        return user.familyName.isEmpty ||
               user.name.isEmpty ||
               user.email.isEmpty ||
               user.password.isEmpty
    }
    
    @objc private func saveUser() {
        let user = UserData(
            familyName: familyNameTextField.text ?? "",
            name: nameTextField.text ?? "",
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? ""
        )
        
        // 1. 입력 정보 값이 비어있는 경우
        if checkIsEmpty(user: user) {
            showAlert?("가입 오류", "모든 항목을 기입해주세요.")
            
        // 2. 유효하지 않은 이메일일 경우
        } else if !emailTextField.isValidEmail(email: user.email) {
            showAlert?("이메일 오류", "올바른 이메일을 입력해주세요.")
            
        // 3. 유저 정보 저장
        } else {
            UserDefaultsHelper().saveUserData(user: user)
            // TODO: 저장 되었을 경우 화면 이동
            showAlert?("테스트", "저장완료.")
        }
        
    }
    
    @objc private func switchToSignin() {
        delegate?.didTapSigninButton()
    }
    
}
