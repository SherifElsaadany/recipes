//
//  RecipeCell.swift
//  recipes
//
//  Created by Elsaadany on 17/06/2021.
//

import UIKit

class RecipeCell: UITableViewCell, ReusableView {
    
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var healthLabels: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setContentViewBorder()
    }
    
    private func setContentViewBorder() {
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func configure(result: RecipeResult?) {
        self.titleLabel.text = result?.title  ?? ""
        self.sourceLabel.text = "From \(result?.source  ?? "")"
        self.healthLabels.text = result?.healthLabels?.joined(separator: ", ")  ?? ""
        self.recipeImageView.image = UIImage(data: result?.image ?? Data())
        
    }
    
}
