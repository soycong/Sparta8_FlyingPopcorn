//
//  QuantityOptionView.swift
//  FlyingPopcornApp
//
//  Created by 김하민 on 12/18/24.
//

import UIKit

import SnapKit
import Then

final class QuantityOptionView: UIView {
    
    private var quantity = 0
    
    private let label = UILabel().then {
        $0.text = "수량"
        $0.textColor = ._450
    }
    
    private let quantityLabel = UILabel().then {
        $0.text = "0"
        $0.textColor = ._450
    }
    
    private let stepper = UIStepper().then {
        $0.minimumValue = 0
        $0.maximumValue = 10 // 1회 최대 구매 가능 갯수 임의로 설정
        $0.stepValue = 1
        $0.value = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        setSubviews()
        setStepper()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubviews() {
        addSubview(label)
        addSubview(quantityLabel)
        addSubview(stepper)
    }
    
    private func setConstraints() {
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.height.centerY.equalToSuperview()
        }
        
        quantityLabel.snp.makeConstraints { make in
            make.height.centerX.centerY.equalToSuperview()
        }
        
        stepper.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(100)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setStepper() {
        stepper.addTarget(self,
                          action: #selector(stepperValueChanged),
                          for: .valueChanged)
    }
    
    @objc private func stepperValueChanged(_ sender: UIStepper) {
        quantity = Int(sender.value)
        quantityLabel.text = quantity.description
        print("quantity changed to \(quantity)")
    }
}
