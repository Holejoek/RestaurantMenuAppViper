//
//  Builder.swift
//  RestaurantApp
//
//  Created by Иван Тиминский on 13.01.2022.
//

import Foundation
import UIKit

protocol ModuleBuilderProtocol {
    static func createMainMenuModule() -> UIViewController
    static func createNextScreenExample(inputData: Any?) -> UIViewController
}

class ModuleBuilder {
    static func createMainMenuModule() -> UIViewController {
        let router = MainMenuRouter()
        let networkService = NetworkService()
        
        let view: MainMenuViewProtocol = MainMenuViewController()
        let presenter: MainMenuPresenterProtocol = MainMenuPresenter(view: view)
        let interactor: MainMenuInteractorProtocol = MainMenuInteractor(presenter: presenter, networkService: networkService)
        
        view.presenter = presenter
        
        presenter.interactor = interactor
        presenter.router = router
        
        
        return (view as? UIViewController) ?? UIViewController()
    }
    static func createNextScreenExample(inputData: Any?) -> UIViewController {
        return UIViewController()
    }
}
