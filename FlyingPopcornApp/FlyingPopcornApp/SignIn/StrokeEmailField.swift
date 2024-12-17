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
        delegate = self
    }
    
    private func checkIsEmail() -> Bool {
        
        return true
    }
    
}

extension StrokeEmailField: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
