//
//  ColorGuideView.swift
//  FlyingPopcornApp
//
//  Created by 김하민 on 12/18/24.
//

import UIKit

import SnapKit

final class ColorGuideView: UIView {
    private let colorGuide: ColorGuide = .init()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .fp00
        
        addSubview(colorGuide)
        
        colorGuide.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
