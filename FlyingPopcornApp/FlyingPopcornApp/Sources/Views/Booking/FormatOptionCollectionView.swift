//
//  FormatOptionCollectionView.swift
//  FlyingPopcornApp
//
//  Created by 김하민 on 12/16/24.
//

import UIKit

import SnapKit
import Then

final class FormatOptionCollectionView: UICollectionView {
    
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

protocol FormatOptionCellDelegate: AnyObject {
    func formatOptionTapped(_ sender: UIButton)
}

final class FormatOptionCell: UICollectionViewCell {
    
    weak var delegate: FormatOptionCellDelegate?
    static let id = "FormatOptionCell"
    
    private let formatOptionButton = UIButton(type: .system).then {
        $0.layer.cornerRadius = 16
        $0.backgroundColor = .available
        $0.tintColor = .availableText
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .clear
        contentView.addSubview(formatOptionButton)
        
        setConstraints()
        
        formatOptionButton.addTarget(self,
                                     action: #selector(onTap),
                                     for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        formatOptionButton.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func setButton(to title: String, delegate: FormatOptionCellDelegate) {
        formatOptionButton.setTitle(title, for: .normal)
        self.delegate = delegate
    }
    
    @objc private func onTap(_ sender: UIButton) {
        
        delegate?.formatOptionTapped(sender)
    }
}
