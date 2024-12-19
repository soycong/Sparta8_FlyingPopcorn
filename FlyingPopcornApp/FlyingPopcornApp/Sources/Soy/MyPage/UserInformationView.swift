//
//  UserInformationView.swift
//  FlyingPopcornApp
//
//  Created by seohuibaek on 12/17/24.
//

import UIKit

import SnapKit
import Then

final class UserInformationView: UIView {
    private let profileImageView = UIImageView().then {
        $0.image = UIImage(systemName: "person.crop.circle.fill")?.withRenderingMode(.alwaysTemplate)  // 시스템 이미지 설정
        $0.tintColor = .gray
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    private let userNicknameLabel = UILabel().then {
        $0.text = "NickName"
        $0.font = .boldSystemFont(ofSize: 14)
        $0.textColor = UIColor(named: "grayDark3")
        $0.textAlignment = .left
    }
    
    private let userEmailLabel = UILabel().then {
        $0.text = "NickName@Email.com"
        $0.font = .systemFont(ofSize: 10)
        $0.textColor = UIColor(named: "grayLight3")
        $0.textAlignment = .left
    }
    
    private let editButton = UIButton().then {
        $0.setTitle("Edit", for: .normal)
        $0.setTitleColor(.blue, for: .normal)
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 8
    }
    
    private lazy var verticalStackView = UIStackView(arrangedSubviews: [userNicknameLabel, userEmailLabel]).then {
        $0.axis = .vertical
        $0.spacing = 5
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    private lazy var horizontalStackView = UIStackView(arrangedSubviews: [profileImageView, verticalStackView]).then {
        $0.axis = .horizontal
        $0.spacing = 5
        $0.alignment = .center
        $0.distribution = .fill
        $0.backgroundColor = .white
        
        // 그림자 설정
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.1 // 그림자 투명도
        $0.layer.shadowOffset = CGSize(width: 0, height: 2) // 그림자 위치
        $0.layer.shadowRadius = 2 // 그림자 퍼짐 정도
        $0.layer.masksToBounds = false // 그림자가 표시되도록 설정
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        //self.layer.cornerRadius = 16
        
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(horizontalStackView)
    }
    
    private func configureConstraints() {
        
        horizontalStackView.snp.makeConstraints { make in
            make.top.equalTo(self.profileImageView.snp.top).offset(-10)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.horizontalStackView.snp.leading).offset(16)
            make.width.equalTo(self.profileImageView.snp.height)
            make.height.equalTo(60)
        }
        
        userNicknameLabel.snp.makeConstraints { make in
            make.height.equalTo(14)
            make.leading.equalTo(self.verticalStackView.snp.leading)
            make.trailing.equalTo(self.verticalStackView.snp.trailing)
        }
        
        userEmailLabel.snp.makeConstraints { make in
            make.height.equalTo(10)
            make.leading.equalTo(self.verticalStackView.snp.leading)
            make.trailing.equalTo(self.verticalStackView.snp.trailing)
        }
        
        //        editButton.snp.makeConstraints { make in
        //            make.width.equalTo(profileImageView.snp.height)
        //            make.trailing.equalTo(self.horizontalStackView.snp.trailing)
        //        }
    }
}

//유저 데이터 업데이트
extension UserInformationView {
    func updateDisplay(name: String, email: String) {
        userNicknameLabel.text = name
        userEmailLabel.text = email
    }
    
    func showLoginRequired() {
        userNicknameLabel.text = "로그인이 필요합니다."
        userEmailLabel.text = ""
    }
}
