//
//  FilterCell.swift
//  recipes
//
//  Created by Elsaadany on 17/06/2021.
//

import UIKit

class FilterCell: UICollectionViewCell, ReusableView {
    
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addTitleLabel() {
        self.addSubview(title)
        setLabelConstraints()
    }
    
    private func setLabelConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            title.topAnchor.constraint(equalTo: self.topAnchor),
            title.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
