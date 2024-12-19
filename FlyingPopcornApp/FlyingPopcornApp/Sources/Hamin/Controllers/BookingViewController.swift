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
    
    private let cinemaModel: Cinema = .init()
    
    private let dateOptionView: DateOptionView = .init(with: Cinema.schedule)
    private let timeOptionView: TimeOptionView = .init()
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
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
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
        confirmButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(24)
            make.height.equalTo(48)
        }
        
        colorGuideView.snp.makeConstraints { make in
            make.width.equalTo(confirmButton.snp.width)
            make.bottom.equalTo(confirmButton.snp.top).offset(-40)
            make.centerX.equalTo(confirmButton)
        }
        
        quantityOptionView.snp.makeConstraints { make in
            make.top.equalTo(timeOptionView.snp.bottom).offset(10)
            make.bottom.equalTo(quantityOptionView.snp.top).offset(50)
            make.leading.trailing.equalToSuperview()
        }
        
        timeOptionView.snp.makeConstraints { make in
            make.top.equalTo(formatOptionView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(170)
        }
        
        formatOptionView.snp.makeConstraints { make in
            make.top.equalTo(dateOptionView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        dateOptionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(70)
        }
    }
    
    private func setButton() {
        confirmButton.addTarget(self,
                                action: #selector(onTap),
                                for: .touchUpInside)
    }
    
    @objc private func onTap() {
        print("confirmButton Tapped")
        guard let time = dateOptionView.selectedDate?.date?.description,
              let format = formatOptionView.selectedFormat?.titleLabel?.text else { return }
        let quantity = quantityOptionView.selectedQuantity.description
        
        // TO-DO: alert창 띄워서 예매 목록 or 홈화면으로 가게 선택
        let alert = UIAlertController(title: "예매 내역 확인",
                                      message: "영화: \(movie.title)\n 시간: \(time)\n 포맷: \(format)\n 수량: \(quantity)",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            print("확인 버튼 누름")
            
//            self.confirmBooking()
            
            
        }))

//        alert.addAction(UIAlertAction(title: "취소", style: .destructive, handler: { _ in
//            print("취소됨")
//        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
        
        let bookedTicket = Ticket(movie: movie,
                                  date: dateOptionView.selectedDate?.date ?? Date.distantPast,
                                  format: (formatOptionView.selectedFormat?.titleLabel?.text)!,
                                  quantity: quantityOptionView.selectedQuantity)
        
        Tickets.bookedTickets.append(bookedTicket)
        
        print("Ticket 생성됨: \(String(describing: bookedTicket))")
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
//    func confirmBooking() {
//        let bookedTicket = Ticket(movie: movie,
//                                  date: dateOptionView.selectedDate?.date ?? Date.distantPast,
//                                  format: (formatOptionView.selectedFormat?.titleLabel?.text)!,
//                                  quantity: quantityOptionView.selectedQuantity)
//        
//        Tickets.bookedTickets.append(bookedTicket)
//        
//        print("Ticket 생성됨: \(String(describing: bookedTicket))")
//    }
}

extension BookingViewController: DateOptionViewDelegate {
    func dateTapped(_ sender: DateButton) {
        guard let date = sender.date else { return }
        let selectedDate = Calendar.current.startOfDay(for: date)
        
        let filteredDate = Cinema.schedule.filter { date in
            Calendar.current.isDate(date, inSameDayAs: selectedDate)
        }
        
        timeOptionView.setTimetable(with: filteredDate)
    }
}
