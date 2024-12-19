//
//  HomePaddedLabel.swift
//  FlyingPopcornApp
//
//  Created by t0000-m0112 on 2024-12-17.
//

import UIKit

final class HomePaddedLabel: UILabel {
    
    // 패딩 설정
    var textInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    
    override func drawText(in rect: CGRect) {
        let insets = textInsets
        let insetRect = rect.inset(by: insets)
        super.drawText(in: insetRect)
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + textInsets.left + textInsets.right,
                      height: size.height + textInsets.top + textInsets.bottom)
    }
}
