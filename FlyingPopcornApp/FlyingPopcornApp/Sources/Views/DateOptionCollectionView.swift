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
        layout.scrollDirection = .vertical
        self.init(frame: .zero, collectionViewLayout: layout)
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol DateOptionCellDelegate: AnyObject {
    func cellTapped(_ sender: UIButton)
}

final class DateOptionCell: UICollectionViewCell {
    
    weak var delegate: DateOptionCellDelegate?
    static let id = "DateOptionCell"
    
    private let dateOptionButton = UIButton(type: .system).then {
        $0.layer.cornerRadius = 16
        // TO-DO: get right button colors
        $0.backgroundColor = .white
        $0.tintColor = .black
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConstraints()
        
        dateOptionButton.addTarget(self,
                                   action: #selector(onTap),
                                   for: .touchUpInside)
        
        contentView.backgroundColor = .clear
        contentView.addSubview(dateOptionButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        dateOptionButton.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func setButton(to title: String, delegate: DateOptionCellDelegate) {
        dateOptionButton.setTitle(title, for: .normal)
        self.delegate = delegate
    }
    
    @objc private func onTap(_ sender: UIButton) {
        delegate?.cellTapped(sender)
    }
}
