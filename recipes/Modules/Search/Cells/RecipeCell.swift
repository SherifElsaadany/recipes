//
//  RecipeCell.swift
//  recipes
//
//  Created by Elsaadany on 17/06/2021.
//

import UIKit

class RecipeCell: UITableViewCell, ReusableView {

    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    private func configureLayout() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
}
