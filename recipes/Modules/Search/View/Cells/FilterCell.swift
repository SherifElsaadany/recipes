//
//  FilterCell.swift
//  recipes
//
//  Created by Elsaadany on 17/06/2021.
//

import UIKit

class FilterCell: UICollectionViewCell, ReusableView {
    
    let titleLabel = UILabel()
    
    override var isSelected: Bool {
        didSet {
            self.titleLabel.textColor = isSelected ? UIColor(named: "titleColor") : #colorLiteral(red: 1, green: 0.6039215686, blue: 0.6039215686, alpha: 1)
            self.backgroundColor = UIColor(named: "menuColor")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addTitleLabel() {
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.numberOfLines = 2
        self.addSubview(titleLabel)
        setLabelConstraints()
    }
    
    private func setLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
