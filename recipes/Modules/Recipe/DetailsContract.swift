//
//  DetailsContract.swift
//  recipes
//
//  Created by Elsaadany on 19/06/2021.
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewDetailsProtocol: class {
    
    var presenter: ViewToPresenterDetailsProtocol? { get set }
    
    func updateDetailsView(title: String, imageUrl: String, ingredients: String)
        
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterDetailsProtocol: class {
    
    var view: PresenterToViewDetailsProtocol? { get set }
    var interactor: PresenterToInteractorDetailsProtocol? { get set }
    var router: RouterDetailsProtocol? { get set }
    
    func viewDidLoad()
    func didTapWebite()
    func didTapShare()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorDetailsProtocol: class {
    
    var presenter: InteractorToPresenterDetailsProtocol? { get set }
    
    func getRecipe()
    func getRecipeUrl() -> String?
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterDetailsProtocol: class {
    
    func fetchDidRetrieve(details: Recipe?)
}


// MARK: Router Input (Presenter -> Router)
protocol RouterDetailsProtocol: class {
    
    var entry: DetailsEntryPoint? { get }
    
    static func start(with recipe: Recipe) -> RouterDetailsProtocol
    
    func presentWebSite(with url: String)
    func presentShareController(with url: String)
}
