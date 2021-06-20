//
//  RecipeCell.swift
//  recipes
//
//  Created by Elsaadany on 17/06/2021.
//

import UIKit
import Kingfisher

class RecipeCell: UITableViewCell, ReusableView {
    
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var healthLabels: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    func configure(result: RecipeResult?) {
        self.titleLabel.text = result?.title  ?? ""
        self.sourceLabel.text = "From \(result?.source  ?? "")"
        self.healthLabels.text = result?.healthLabels?.joined(separator: ",  ")  ?? ""
        if let url = URL(string: result?.image ?? "")  {
            recipeImageView.kf.indicatorType = .activity
            recipeImageView.kf.setImage(with: url)
        }
    }
    
}
