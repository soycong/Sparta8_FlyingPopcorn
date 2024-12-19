//
//  StrokeTextField.swift
//  Sai
//
//  Created by CHYUN on 12/16/24.
//
import UIKit
import SnapKit

final class StrokePasswordField: StrokeTextField {
    
    private var isShown = false
    private var eyeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    
    override init(hintText: String, frame: CGRect = .zero) {
        super.init(hintText: hintText, frame: frame)
        setPasswordField()
        setPasswordShownButtonImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setPasswordField() {
        isSecureTextEntry = true
        textContentType = .oneTimeCode
        rightView = eyeButton
        rightViewMode = .always
    }
    
    // 비밀번호 눈 이미지
    private func setPasswordShownButtonImage() {
        eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        eyeButton.tintColor = .fp300
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        rightPaddingView.addSubview(eyeButton)
        
        eyeButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(40)
        }
    }
    
    @objc private func togglePasswordVisibility() {
        isSecureTextEntry.toggle()
        let imageName = isSecureTextEntry ? "eye.slash" : "eye"
        eyeButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
}
