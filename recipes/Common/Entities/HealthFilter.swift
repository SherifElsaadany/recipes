//
//  HealthFilter.swift
//  recipes
//
//  Created by Elsaadany on 18/06/2021.
//

import Foundation

struct HealthFilter {
    
    enum Filter: String {
        case all = "All"
        case lowSugar = "Low Sugar"
        case keto = "Keto"
        case vegan = "Vegan"
    }
    
    let items: [Filter] = [.all, .lowSugar, .keto, .vegan]
}
