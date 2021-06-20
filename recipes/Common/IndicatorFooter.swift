//
//  IndicatorFooter.swift
//  recipes
//
//  Created by Elsaadany on 20/06/2021.
//

import UIKit

class IndicatorFooter: UIView {
    
    var spinner = UIActivityIndicatorView(style: .white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "navColor")
        addSpinner()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func addSpinner() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        self.addSubview(spinner)
        spinner.hidesWhenStopped = true
        
        spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func startSpinner() {
        spinner.startAnimating()
    }
    
    func stopSpinner() {
        spinner.stopAnimating()
    }
}
