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
    func getMealCategoryCell(for indexPath: IndexPath) -> CategoryCellWithSelectedFlag
    
    func getNumberOfCategories() -> Int
    func getNumberOfRows(for section: Int) -> Int
    func getNumberOfSection() -> Int
    
    func getHeightForRowAt(for indexPath: IndexPath, heighOfView: Double) -> Double
    func getHeightForHeader(for section: Int, heightOfView: Double) -> Double
    
    func wasSelectedRowAt(indexPath: IndexPath)
    func wasSelectCategory(at indexPath: IndexPath)
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
    
    //MARK: Data
    func getMealInfo(for indexPath: IndexPath) -> Meal {
        let meal: Meal = interactor.loadedMeals.value[indexPath.item]
        return meal
    }
    
    func getMealCategoryCell(for indexPath: IndexPath) -> CategoryCellWithSelectedFlag {
        guard let list = interactor.loadedCategories.value else { return (category: "", isSelected: false)}
        let category = list[indexPath.item].strCategory
        let isSelected = interactor.checkThatCategorySelectedAt(indexPath: indexPath)
        return (category: category, isSelected: isSelected)
    }
    
    //MARK: Counting
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
    
    func getNumberOfSection() -> Int {
        return 2
    }
    
    //MARK: Sizing
    func getHeightForRowAt(for indexPath: IndexPath, heighOfView: Double) -> Double {
        if indexPath.section == 0 {
            return heighOfView / 5
        } else if indexPath.section == 1 {
            return heighOfView / 5
        }
        return 0
    }
    
    func getHeightForHeader(for section: Int, heightOfView: Double) -> Double {
        switch section {
        case 1:
            return heightOfView / 15
        default:
            return 0
        }
    }
    
    //MARK: Events
    func wasSelectedRowAt(indexPath: IndexPath) {
        
    }
    
    func wasSelectCategory(at indexPath: IndexPath) {
        interactor.categoryWasSelected(indexOfCategory: indexPath.item)
    }
}
