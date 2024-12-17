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
        $0.image = UIImage(named: "MoviePoster2")
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
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userNicknameLabel, userEmailLabel]).then {
            $0.axis = .vertical
            $0.spacing = 5
            $0.alignment = .center
            $0.distribution = .fill
        }
        return stackView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImageView, verticalStackView, editButton]).then {
            $0.axis = .horizontal
            $0.spacing = 5
            $0.alignment = .center
            $0.distribution = .fill
            $0.backgroundColor = .white
        }
        return stackView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 16
        
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
            //make.centerY.equalToSuperview()
            make.top.equalTo(self.profileImageView.snp.top).offset(-10)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(5)
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
        
        editButton.snp.makeConstraints { make in
            make.width.equalTo(profileImageView.snp.height)
            make.trailing.equalTo(self.horizontalStackView.snp.trailing)
        }
    }
}
