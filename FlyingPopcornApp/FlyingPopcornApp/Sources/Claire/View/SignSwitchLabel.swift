//
//  SignSwitchLabel.swift
//  Sai
//
//  Created by CHYUN on 12/17/24.
//

import UIKit

final class SignSwitchLabel: UIView {
    private let question: String
    private let buttonTitle: String
    private let buttonEvent: ()->()
    
    private let questionLabel = UILabel()
    private let switchButton = UIButton()
    
    init(question: String, buttonTitle: String, buttonEvent: @escaping ()->(), frame: CGRect) {
        self.question = question
        self.buttonTitle = buttonTitle
        self.buttonEvent = buttonEvent
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        [questionLabel, switchButton].forEach { view in
            addSubview(view)
        }
        
        questionLabel.text = question
        questionLabel.textColor = .fp200
        questionLabel.font = .systemFont(ofSize: 14)
        
        switchButton.setTitle(buttonTitle, for: .normal)
        switchButton.setTitleColor(.fpRed, for: .normal)
        switchButton.titleLabel?.font = .systemFont(ofSize: 14)
        switchButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        questionLabel.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
        }
        switchButton.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalTo(questionLabel.snp.trailing).offset(2)
        }
    }
    
    @objc private func buttonTapped() {
        buttonEvent()
    }
}
