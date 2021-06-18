//
//  SearchRouter.swift
//  recipes
//
//  Created by Elsaadany on 18/06/2021.
//

import UIKit

typealias EntryPoint = PresenterToViewSearchProtocol & UIViewController

class SearchRouter: RouterSearchProtocol {
    
    typealias SearchPresenterProtocol = ViewToPresenterSearchProtocol & InteractorToPresenterSearchProtocol
    
    
    var entry: EntryPoint?
    
    static func start() -> RouterSearchProtocol {
        
        let webService = WebServices()
        
        let router = SearchRouter()
        let view: EntryPoint = SearchVC()
        let presenter: SearchPresenterProtocol = SearchPresenter()
        let interactor: PresenterToInteractorSearchProtocol = SearchInteractor(webService: webService)
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view
        
        return router
    }
    
    func pushToRecipeDetails(on view: PresenterToViewSearchProtocol, with quote: Recipe) {
        
    }

}
