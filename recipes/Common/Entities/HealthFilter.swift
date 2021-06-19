//
//  HealthFilter.swift
//  recipes
//
//  Created by Elsaadany on 18/06/2021.
//

import Foundation

enum HealthFilter: String {
    static let items: [HealthFilter] = [.all, .lowSugar, .keto, .vegan]
    
    case all = "All"
    case lowSugar = "low-sugar"
    case keto = "keto-friendly"
    case vegan = "vegan"
    
}
