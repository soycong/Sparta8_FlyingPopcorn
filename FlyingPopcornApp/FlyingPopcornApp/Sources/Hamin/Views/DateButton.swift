//
//  DateButton.swift
//  FlyingPopcornApp
//
//  Created by 김하민 on 12/19/24.
//

import UIKit

final class DateButton: UIButton {
    
    var date: Date?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
