//
//  TimeOptionCollectionView.swift
//  FlyingPopcornApp
//
//  Created by 김하민 on 12/16/24.
//

import UIKit

import SnapKit
import Then

final class TimeOptionCollectionView: UICollectionView {
    
    convenience init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .fp50
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

protocol TimeOptionCellDelegate: AnyObject {
    func timeOptionTapped(_ sender: DateButton)
}

final class TimeOptionCell: UICollectionViewCell {
    
    weak var delegate: TimeOptionCellDelegate?
    static let id = "TimeOptionCell"
    
    private let timeOptionButton = DateButton(type: .system).then {
        $0.layer.cornerRadius = 16
        $0.backgroundColor = .available
        $0.tintColor = .availableText
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .clear
        contentView.addSubview(timeOptionButton)
        
        setConstraints()
        
        timeOptionButton.addTarget(self,
                                   action: #selector(onTap),
                                   for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        timeOptionButton.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func setButton(to date: Date, delegate: TimeOptionCellDelegate?) {
        timeOptionButton.date = date
        timeOptionButton.setTitle(date.hourAndMinuteOnly, for: .normal)
        self.delegate = delegate
    }
    
    // 
    @objc private func onTap(_ sender: DateButton) {
        
        delegate?.timeOptionTapped(sender)
        
    }
    
}




