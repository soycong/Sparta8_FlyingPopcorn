//
//  DateOptionCollectionView.swift
//  FlyingPopcornApp
//
//  Created by 김하민 on 12/17/24.
//

import UIKit

import SnapKit
import Then

final class DateOptionCollectionView: UICollectionView {
    
    convenience init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .clear
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol DateOptionCellDelegate: AnyObject {
    func dateOptionTapped(_ sender: DateButton)
}

final class DateOptionCell: UICollectionViewCell {
    
    weak var delegate: DateOptionCellDelegate?
    static let id = "DateOptionCell"
    
    private let dateOptionButton = DateButton(type: .system).then {
        $0.layer.cornerRadius = 16
        // TO-DO: get right button colors
        $0.backgroundColor = .available
        $0.tintColor = .clear
        
        $0.titleLabel?.numberOfLines = 2
        $0.titleLabel?.textAlignment = .center
        $0.titleLabel?.lineBreakMode = .byWordWrapping
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(dateOptionButton)
        
        dateOptionButton.addTarget(self,
                                   action: #selector(onTap),
                                   for: .touchUpInside)
        
        contentView.backgroundColor = .clear
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        dateOptionButton.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    // TO-DO: rework title format from String to Date?
    func setButton(to date: Date, delegate: DateOptionCellDelegate) {
        dateOptionButton.date = date
        let day = date.dayOnly
        let weekDay = date.weekdayOnly
        dateOptionButton.setTitle("\(day)\n\(weekDay)", for: .normal)
        self.delegate = delegate
    }
    
    @objc private func onTap(_ sender: DateButton) {
        delegate?.dateOptionTapped(sender)
    }
}

//extension UIButton {
//    internal var date: Date = Date()
//}
