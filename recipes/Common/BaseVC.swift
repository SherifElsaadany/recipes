//
//  BaseVC.swift
//  recipes
//
//  Created by Elsaadany on 20/06/2021.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavBar()
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1058823529, green: 0.09019607843, blue: 0.09019607843, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
    }
}
