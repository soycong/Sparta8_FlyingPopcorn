//
//  MainSolidButton.swift
//  Sai
//
//  Created by CHYUN on 12/16/24.
//

import UIKit

import SnapKit

final class MainSolidButton: UIButton {
    
    private let title: String
    
    init(title: String, frame: CGRect = .zero) {
        self.title = title
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        
        backgroundColor = .fpRed
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
    
}
