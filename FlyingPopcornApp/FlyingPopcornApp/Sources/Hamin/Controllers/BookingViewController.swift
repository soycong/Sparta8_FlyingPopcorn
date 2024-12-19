//
//  BookingViewController.swift
//  FlyingPopcornApp
//
//  Created by 김하민 on 12/16/24.
//

import UIKit

import SnapKit

final class BookingViewController: UIViewController {
    
    var movie: Movie
    var bookedTicket: Ticket?
    
    private let cinemaModel: Cinema = .init()
    
    private let dateOptionView: DateOptionView = .init(with: Cinema.schedule)
    private let timeOptionView: TimeOptionView = .init(with: Cinema.schedule)
    private let formatOptionView: FormatOptionView = .init(with: Cinema.availableFormat)
    private let quantityOptionView: QuantityOptionView = .init()
    private let colorGuideView: ColorGuideView = .init()
    
    // TO-DO: 모든 옵션을 선택하지 않았으면 버튼 회색처리 + 탭 안되게
    private let confirmButton = UIButton().then {
        $0.setTitle("결제하기", for: .normal)
        $0.backgroundColor = .fpRed
        $0.setTitleColor(.fp00, for: .normal)
        $0.layer.cornerRadius = 24
    }
    
//    convenience init(movie: Movie) {
//        self.init(movie: movie)
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray
        
        setViews()
        setButton()
        setConstraints()
        dateOptionView.setDelegate(to: self)
    }

    private func setViews() {
        view.addSubview(dateOptionView)
        view.addSubview(formatOptionView)
        view.addSubview(timeOptionView)
        view.addSubview(quantityOptionView)
        view.addSubview(colorGuideView)
        view.addSubview(confirmButton)
    }
    
    private func setConstraints() {
        dateOptionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(70)
        }
        
        formatOptionView.snp.makeConstraints { make in
            make.top.equalTo(dateOptionView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        timeOptionView.snp.makeConstraints { make in
            make.top.equalTo(formatOptionView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(170)
        }
        
        quantityOptionView.snp.makeConstraints { make in
            make.top.equalTo(timeOptionView.snp.bottom).offset(10)
            make.bottom.equalTo(quantityOptionView.snp.top).offset(50)
            make.leading.trailing.equalToSuperview()
        }
        
        colorGuideView.snp.makeConstraints { make in
            make.top.equalTo(quantityOptionView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
    
    private func setButton() {
        confirmButton.addTarget(self,
                                action: #selector(onTap),
                                for: .touchUpInside)
    }
    
    @objc private func onTap() {
        print("confirmButton Tapped")
        print(dateOptionView.selectedDate?.titleLabel?.text ?? "no value")
        print(formatOptionView.selectedFormat?.titleLabel?.text ?? "no value")
        print(timeOptionView.selectedTime?.titleLabel?.text ?? "no value")
        print(quantityOptionView.selectedQuantity.description)
        
        bookedTicket = Ticket(movie: movie,
                              date: Date(), // 작업중이라 임시로 현재 시간 넣음
                              format: (formatOptionView.selectedFormat?.titleLabel?.text)!,
                              quantity: quantityOptionView.selectedQuantity)
    }
}

extension BookingViewController: DateOptionViewDelegate {
    func dateTapped(_ sender: DateButton) {
        guard let date = sender.date else { return }
        let selectedDate = Calendar.current.startOfDay(for: date)
        
        Cinema.schedule.filter { date in
            Calendar.current.isDate(date, inSameDayAs: selectedDate)
        }
    }
}
