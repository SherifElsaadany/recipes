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
    func loadCollectionView()
    func showAlertMessage(error: String)
    func hideTableView()
    
    func showHUD()
    func hideHUD()
    
    func showFooterIndicator()
    func hideFooterIndicator()
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterSearchProtocol: class {
    
    var view: PresenterToViewSearchProtocol? { get set }
    var interactor: PresenterToInteractorSearchProtocol? { get set }
    var router: RouterSearchProtocol? { get set }
    var numberOfRows: Int? { get set }
    var numberOfCollectionViewItems: Int? { get set }
    
    func viewDidLoad()
    func filterItem(at index: Int) -> String?
    func search(for query: String, at filterIndex: Int)
    func resultCell(at index: Int) -> RecipeResult?
    func didDisplayLastRow()
    func didSelectRowAt(index: Int)
    func didSelectFilterItemAt(index: Int)

}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSearchProtocol: class {
    
    var presenter: InteractorToPresenterSearchProtocol? { get set }
    var webService: WebServiceProtocol? { get set }
    var isFetchingPage: Bool { get set }
    
    func loadFilterItems()
    func getFilterItem(at index: Int) -> HealthFilter
    func loadSearchResults(for query: String)
    func loadNextPage()
    func getSearchResult(at index: Int) -> Recipe?
    func filterResults(of query: String, filterIndex: Int)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterSearchProtocol: class {
    
    func didLoadFilterItems(count: Int)
    func fetchDidRetrieve(count: Int?)
    func fetchDidFail(error: String)
    func noMorePages()
}


// MARK: Router Input (Presenter -> Router)
protocol RouterSearchProtocol: class {
    
    var entry: EntryPoint? { get }
    
    static func start() -> RouterSearchProtocol
    
    func pushToRecipeDetails(with recipe: Recipe)
}
