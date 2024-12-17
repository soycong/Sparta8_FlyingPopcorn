//
//  BookingViewController.swift
//  FlyingPopcornApp
//
//  Created by 김하민 on 12/16/24.
//

import UIKit

import SnapKit

final class BookingViewController: UIViewController {

    private let timeOptionView: TimeOptionView = .init()
    private let formatOptionView: FormatOptionView = .init()
    private let colorGuide: ColorGuide = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray
        
        setViews()
        setConstraints()
    }

    private func setViews() {
        view.addSubview(formatOptionView)
        view.addSubview(timeOptionView)
        view.addSubview(colorGuide)
    }
    
    private func setConstraints() {
        formatOptionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
        
        timeOptionView.snp.makeConstraints { make in
            make.top.equalTo(formatOptionView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        colorGuide.snp.makeConstraints { make in
            make.top.equalTo(timeOptionView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(30)
        }
    }
}
