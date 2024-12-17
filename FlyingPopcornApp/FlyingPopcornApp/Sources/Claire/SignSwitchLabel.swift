//
//  SignSwitchLabel.swift
//  Sai
//
//  Created by CHYUN on 12/17/24.
//
import UIKit

final class SignSwitchLabel: UIStackView {
    private let question: String
    private let buttonTitle: String
    private let buttonEvent: ()->()
    
    private let questionLabel = UILabel()
    private let switchButton = TextButton()
    
    init(question: String, buttonTitle: String, buttonEvent: @escaping ()->(), frame: CGRect) {
        self.question = question
        self.buttonTitle = buttonTitle
        self.buttonEvent = buttonEvent
        super.init(frame: frame)
        setupUI()
        
        axis = .horizontal
        spacing = 2
        distribution = .equalCentering
        alignment = .center
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        [questionLabel, switchButton].forEach { view in
            addArrangedSubview(view)
        }
        
        questionLabel.text = question
        questionLabel.textColor = .systemGray2
        questionLabel.font = .systemFont(ofSize: 14)
        
        switchButton.setTitle(buttonTitle, for: .normal)

    }
    
    class TextButton: UIButton {
        override init(frame: CGRect = .zero) {
            super.init(frame: frame)
            
            var config = UIButton.Configuration.plain()
            config.contentInsets = .zero
            configuration = config
            
            setTitleColor(UIColor(red: 220/255, green: 71/255, blue: 71/255, alpha: 1.0), for: .normal)
            titleLabel?.font = .systemFont(ofSize: 14)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
