//
//  MainMenuPresenter.swift
//  RestaurantApp
//
//  Created by Иван Тиминский on 13.01.2022.
//

import Foundation

protocol MainMenuPresenterProtocol: AnyObject {
    var router: MainMenuRouterProtocol! { get set }
    var interactor: MainMenuInteractorProtocol! { get set }
    
    func notifyThatViewDidLoad()
    
    func getMealInfo(for indexPath: IndexPath) -> Meal
    func getMealDiscription(for indexPath: IndexPath) -> String
    func getMealCategory(for indexPath: IndexPath) -> String
    func notifyThatMenuCellNeedDiscriptionAt(indexPath: IndexPath) -> String
    
    func getNumberOfCategories() -> Int
    func getNumberOfRows(for section: Int) -> Int
    func getHeightForRowAt(for indexPath: IndexPath, heighOfView: Double) -> Double
    func getHeightForHeader(for section: Int, heightOfView: Double) -> Double
    func didSelectRowAt(indexPath: IndexPath)
}

class MainMenuPresenter:  MainMenuPresenterProtocol {
    
    var router: MainMenuRouterProtocol!
    var interactor: MainMenuInteractorProtocol!
    weak var view: MainMenuViewProtocol!
    
    required init(view: MainMenuViewProtocol) {
        self.view = view
    }
    
    func notifyThatViewDidLoad() {
        interactor.startNetworkServiceForMainMenu()
        makeDataBinding()
    }
    private func makeDataBinding() {
        interactor.loadedCategories.bind { [weak self] _ in
            self?.view.updateCategoriesCollectionView()
        }
        
        interactor.loadedMeals.bind { [weak self] _ in
            self?.view.updateCellsForSection(section: 1)
        }
    }
    
    func getMealInfo(for indexPath: IndexPath) -> Meal {
        let meal: Meal = interactor.loadedMeals.value[indexPath.item]
        return meal
    }
    
    func getMealDiscription(for indexPath: IndexPath) -> String {
        return interactor.getMealDiscriptions(for: indexPath)
    }
    
    func getMealCategory(for indexPath: IndexPath) -> String {
        guard let list = interactor.loadedCategories.value else { return ""}
        return list[indexPath.item].strCategory
    }
    
    func notifyThatMenuCellNeedDiscriptionAt(indexPath: IndexPath) -> String {
        return interactor.getMealDiscriptions(for: indexPath)
    }
    
    func getNumberOfCategories() -> Int {
        return interactor.getCountOfLoadedCategories()
    }
    
  
    
    func getNumberOfRows(for section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return interactor.getCountOfLoadedMeals()
        }
        return 0 
    }
    
    func getHeightForRowAt(for indexPath: IndexPath, heighOfView: Double) -> Double {
        if indexPath.section == 0 {
            return heighOfView / 6
        } else if indexPath.section == 1 {
            return heighOfView / 5
        }
        return 0
    }
    
    func getHeightForHeader(for section: Int, heightOfView: Double) -> Double {
        switch section {
        case 0:
            return 0
        case 1:
            return heightOfView / 8
        default:
            return 0
        }
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        
    }
}
