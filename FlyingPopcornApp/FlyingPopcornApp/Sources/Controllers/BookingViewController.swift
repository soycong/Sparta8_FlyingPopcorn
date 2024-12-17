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

    private var selectedFormat: UIButton?
    private var selectedTime: UIButton?

    private let formatOptions = ["2D", "3D", "IMAX"]

    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionViews()
        setConstraints()
    }

    private func setCollectionViews() {
        view.addSubview(timeOptionView)
    }
    
    private func setConstraints() {
        timeOptionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
