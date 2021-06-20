//
//  RecipeDetailsVC.swift
//  recipes
//
//  Created by Elsaadany on 17/06/2021.
//

import UIKit
import Kingfisher
import SafariServices

class RecipeDetailsVC: BaseVC, SFSafariViewControllerDelegate {
    
    var presenter: ViewToPresenterDetailsProtocol?
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var ingredientsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTextView.isEditable = false
        self.presenter?.viewDidLoad()
        addShareBtn()
//        recipeImageView.layer.cornerRadius = 10
    }
    
    @IBAction func recipeWebsiteTapped(_ sender: Any) {
        presenter?.didTapWebite()
    }
}

//MARK:- Methods
extension RecipeDetailsVC {
    func addShareBtn() {
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(#imageLiteral(resourceName: "share"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(shareTapped), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func shareTapped() {
        presenter?.didTapShare()
    }
}

//MARK:- PresenterToViewDetailsProtocol
extension RecipeDetailsVC: PresenterToViewDetailsProtocol {
    
    func updateDetailsView(title: String, imageUrl: String, ingredients: String) {
        self.title = title
        self.ingredientsTextView.text = ingredients
        if let url = URL(string: imageUrl)  {
            recipeImageView.kf.indicatorType = .activity
            recipeImageView.kf.setImage(with: url)
        }
    }
}
