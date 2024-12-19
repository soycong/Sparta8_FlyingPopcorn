//
//  BookingViewController.swift
//  FlyingPopcornApp
//
//  Created by 김하민 on 12/16/24.
//

import UIKit

import SnapKit
import Then

final class BookingViewController: UIViewController {
    
    var movie: Movie
    
    private let cinemaModel: Cinema = .init()
    
    private let redBackdrop = UIView().then {
        $0.backgroundColor = .fpRed
        $0.layer.zPosition = 0
    }
    
    private let roundView = UIView().then {
        $0.backgroundColor = .fp00
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.zPosition = 1
        $0.clipsToBounds = true
    }
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
        view.backgroundColor = .fp00
        
        setViews()
        setButton()
        setConstraints()
        dateOptionView.setDelegate(to: self)
    }
    
    private func setNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = nil
        appearance.shadowImage = UIImage()
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let naviLeftItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(handleBackButton))
        naviLeftItem.tintColor = .fp00
        navigationItem.leftBarButtonItem = naviLeftItem
    }
    
    @objc private func handleBackButton() {
        navigationController?.popViewController(animated: true)
    }

    private func setViews() {
        view.addSubview(redBackdrop)
        view.addSubview(dateOptionView)
        view.addSubview(roundView)
        
        roundView.addSubview(formatOptionView)
        roundView.addSubview(timeOptionView)
        roundView.addSubview(quantityOptionView)
        roundView.addSubview(colorGuideView)
        roundView.addSubview(confirmButton)
    }
    
    private func setConstraints() {
        redBackdrop.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(formatOptionView.snp.top)
        }
        
        roundView.snp.makeConstraints { make in
            make.top.equalTo(redBackdrop.snp.bottom).offset(-20)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        dateOptionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(formatOptionView.snp.top).offset(-40)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(100)
        }
        
        formatOptionView.snp.makeConstraints { make in
            make.bottom.lessThanOrEqualTo(timeOptionView.snp.top).offset(-40)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(70)
        }
        
        timeOptionView.snp.makeConstraints { make in
            make.bottom.lessThanOrEqualTo(quantityOptionView.snp.top).offset(-40)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(190)
        }
        
        quantityOptionView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.bottom.lessThanOrEqualTo(colorGuideView.snp.top).offset(-40)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        colorGuideView.snp.makeConstraints { make in
            make.width.equalTo(confirmButton.snp.width)
            make.bottom.lessThanOrEqualTo(confirmButton.snp.top).offset(-50)
            make.centerX.equalTo(confirmButton)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(24)
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
        guard let time = dateOptionView.selectedDate?.date?.description,
              let format = formatOptionView.selectedFormat?.titleLabel?.text else { return }
        let quantity = quantityOptionView.selectedQuantity.description
        
        // TO-DO: alert창 띄워서 예매 목록 or 홈화면으로 가게 선택
        let alert = UIAlertController(title: "예매 내역 확인",
                                      message: "영화: \(movie.title)\n 시간: \(time)\n 포맷: \(format)\n 수량: \(quantity)",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            print("확인 버튼 누름")
            
            self.confirmBooking()
            
            self.navigationController?.popToRootViewController(animated: true)
        }))

        alert.addAction(UIAlertAction(title: "취소", style: .destructive, handler: nil))

        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    func confirmBooking() {
        let bookedTicket = Ticket(movie: movie,
                                  date: dateOptionView.selectedDate?.date ?? Date.distantPast,
                                  format: (formatOptionView.selectedFormat?.titleLabel?.text)!,
                                  quantity: quantityOptionView.selectedQuantity)
        
        Tickets.bookedTickets.append(bookedTicket)
        
        print("Ticket 생성됨: \(String(describing: bookedTicket))")
    }
}

extension BookingViewController: DateOptionViewDelegate {
    func dateTapped(_ sender: DateButton) {
        timeOptionView.resetCells()
        guard let date = sender.date else { return }
        let selectedDate = Calendar.current.startOfDay(for: date)
        
        let filteredDate = Cinema.schedule.filter { date in
            Calendar.current.isDate(date, inSameDayAs: selectedDate)
        }
        
        timeOptionView.setTimetable(with: filteredDate)
    }
}
