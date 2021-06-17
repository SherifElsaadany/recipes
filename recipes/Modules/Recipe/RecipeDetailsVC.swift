//
//  RecipeDetailsVC.swift
//  recipes
//
//  Created by Elsaadany on 17/06/2021.
//

import UIKit

class RecipeDetailsVC: UIViewController {
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var ingredientsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTextView.isEditable = false
    }
    
    @IBAction func recipeWebsiteTapped(_ sender: Any) {
        
    }
    
}
