//
//  Contract.swift
//  recipes
//
//  Created by Elsaadany on 17/06/2021.
//

import Foundation

protocol ReusableView: class {}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
