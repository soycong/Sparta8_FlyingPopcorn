//
//  StrokeTextField.swift
//  Sai
//
//  Created by CHYUN on 12/16/24.
//

import UIKit

class StrokeTextField: UITextField {
    
    private let hintText: String
    
    init(hintText: String, frame: CGRect = .zero) {
        self.hintText = hintText
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextField() {
        font = UIFont.systemFont(ofSize: 14)
        backgroundColor = .white
        
        autocorrectionType = .no                     // 자동 수정 활성화 여부
        spellCheckingType = .no                      // 맞춤법 검사 활성화 여부
        autocapitalizationType = .none               // 자동 대문자 활성화 여부
        
        attributedPlaceholder = NSAttributedString(string: hintText,
                                                   attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])

        layer.borderWidth = 1
        layer.borderColor = UIColor.fp400.cgColor
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.frame.height))
        leftView = leftPaddingView
        leftViewMode = .always
        
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.frame.height))
        rightView = rightPaddingView
        rightViewMode = .always
    }
    
}
