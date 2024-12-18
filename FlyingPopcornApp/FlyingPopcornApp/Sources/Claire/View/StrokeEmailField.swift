//
//  StrokeTextField.swift
//  Sai
//
//  Created by CHYUN on 12/16/24.
//
import UIKit
import SnapKit

final class StrokeEmailField: StrokeTextField {
    
    private var eyeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    
    override init(hintText: String, frame: CGRect = .zero) {
        super.init(hintText: hintText, frame: frame)
        setupEmailField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupEmailField() {
        keyboardType = .emailAddress
        textContentType = .emailAddress
    }
    
    private func checkIsEmail() -> Bool {
        
        return true
    }
    
    // 이메일 형식 검사
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
}

