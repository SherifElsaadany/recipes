//
//  SearchContract.swift
//  recipes
//
//  Created by Elsaadany on 18/06/2021.
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewSearchProtocol: class {
    
    var presenter: ViewToPresenterSearchProtocol? { get set }
    
    func updateResultsView()
    func showAlertMessage(error: String)
    func updateImage(at index: Int)
    
    func showHUD()
    func hideHUD()
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterSearchProtocol: class {
    
    var view: PresenterToViewSearchProtocol? { get set }
    var interactor: PresenterToInteractorSearchProtocol? { get set }
    var router: RouterSearchProtocol? { get set }
    var numberOfRows: Int? { get set }
    
    
    func search(for query: String)
        
    func resultCell(at index: Int) -> RecipeResult?
    
    func didSelectRowAt(index: Int)

}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSearchProtocol: class {
    
    var presenter: InteractorToPresenterSearchProtocol? { get set }
    var webService: WebServiceProtocol? { get set }
    
    func loadSearchResults(for query: String)
    func getSearchResult(at index: Int) -> RecipeResult?
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterSearchProtocol: class {
    
    func searchDidSuccess(result: [RecipeResult]?)
    func searchDidFail(error: String)
    
    func downloadImageDidSuccess(at index: Int)
    
}


// MARK: Router Input (Presenter -> Router)
protocol RouterSearchProtocol: class {
    
    var entry: EntryPoint? { get }
    
    static func start() -> RouterSearchProtocol
    
    func pushToRecipeDetails(on view: PresenterToViewSearchProtocol, with quote: Recipe)
}
