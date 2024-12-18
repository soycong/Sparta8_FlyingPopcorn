//
//  BookingViewController.swift
//  FlyingPopcornApp
//
//  Created by 김하민 on 12/16/24.
//

import UIKit

import SnapKit

final class BookingViewController: UIViewController {

    private let dateOptionView: DateOptionView = .init()
    private let timeOptionView: TimeOptionView = .init()
    private let formatOptionView: FormatOptionView = .init()
    private let quantityOptionView: QuantityOptionView = .init()
    private let colorGuide: ColorGuide = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray
        
        setViews()
        setConstraints()
    }

    private func setViews() {
        view.addSubview(dateOptionView)
        view.addSubview(formatOptionView)
        view.addSubview(timeOptionView)
        view.addSubview(quantityOptionView)
        view.addSubview(colorGuide)
    }
    
    private func setConstraints() {
        dateOptionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        formatOptionView.snp.makeConstraints { make in
            make.top.equalTo(dateOptionView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
        
        timeOptionView.snp.makeConstraints { make in
            make.top.equalTo(formatOptionView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        quantityOptionView.snp.makeConstraints { make in
            make.top.equalTo(timeOptionView.snp.bottom).offset(10)
            make.bottom.equalTo(quantityOptionView.snp.top).offset(50)
            make.leading.trailing.equalToSuperview()
        }
        
        colorGuide.snp.makeConstraints { make in
            make.top.equalTo(quantityOptionView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(30)
        }
    }
}
