//
//  ColorGuide.swift
//  FlyingPopcornApp
//
//  Created by 김하민 on 12/17/24.
//

import UIKit

import SnapKit
import Then

final class ColorGuide: UIView {
    
    private let availableBox = UIView().then {
        $0.backgroundColor = .available
        $0.layer.cornerRadius = 4
    }
    
    private let unavailableBox = UIView().then {
        $0.backgroundColor = .unavailable
        $0.layer.cornerRadius = 4
    }
    
    private let selectedBox = UIView().then {
        $0.backgroundColor = .selected
        $0.layer.cornerRadius = 4
    }
    
    private let availableLabel = UILabel().then {
        $0.text = "선택 가능"
        $0.textColor = .greyLight3
    }
    
    private let unavailableLabel = UILabel().then {
        $0.text = "선택 불가"
        $0.textColor = .greyLight3
    }
    
    private let selectedLabel = UILabel().then {
        $0.text = "선택됨"
        $0.textColor = .greyLight3
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews() {
//        [
//            availableBox, availableLabel,
//            unavailableBox, unavailableLabel,
//            selectedBox, selectedBox
//        ].forEach { addSubview($0) }
        
        addSubview(availableBox)
        addSubview(availableLabel)
        addSubview(unavailableBox)
        addSubview(unavailableLabel)
        addSubview(selectedBox)
        addSubview(selectedLabel)
    }
    
    private func setConstraints() {
        let boxSize: CGFloat = 12
        let boxLabelDistance: CGFloat = 7
        let leadingTrailingDistance: CGFloat = 16
        
        // 선택 가능
        availableBox.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.size.equalTo(boxSize)
            make.centerY.equalToSuperview()
        }
        availableLabel.snp.makeConstraints { make in
            make.leading.equalTo(availableBox.snp.trailing).offset(boxLabelDistance)
            make.centerY.equalToSuperview()
        }
        
        // 선택 불가
        unavailableBox.snp.makeConstraints { make in
            make.leading.equalTo(availableLabel.snp.trailing).offset(leadingTrailingDistance)
            make.size.equalTo(boxSize)
            make.centerY.equalToSuperview()
        }
        unavailableLabel.snp.makeConstraints { make in
            make.leading.equalTo(unavailableBox.snp.trailing).offset(boxLabelDistance)
            make.centerY.equalToSuperview()
        }
        
        // 선택됨
        selectedBox.snp.makeConstraints { make in
            make.leading.equalTo(unavailableLabel.snp.trailing).offset(leadingTrailingDistance)
            make.size.equalTo(boxSize)
            make.centerY.equalToSuperview()
        }
        selectedLabel.snp.makeConstraints { make in
            make.leading.equalTo(selectedBox.snp.trailing).offset(boxLabelDistance)
            make.centerY.equalToSuperview()
        }
    }
    
}
