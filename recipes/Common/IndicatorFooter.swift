//
//  IndicatorFooter.swift
//  recipes
//
//  Created by Elsaadany on 20/06/2021.
//

import UIKit

class IndicatorFooter: UIView {
    
    let loadingLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "navColor")
        addLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func addLabel() {
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loadingLabel)
        loadingLabel.text = "......"
        loadingLabel.textColor = .white
        loadingLabel.font = loadingLabel.font.withSize(30)
        
        NSLayoutConstraint.activate([
            loadingLabel.topAnchor.constraint(equalTo: self.topAnchor),
            loadingLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
