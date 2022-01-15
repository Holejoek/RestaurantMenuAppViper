//
//  Interactor.swift
//  RestaurantApp
//
//  Created by Иван Тиминский on 13.01.2022.
//

import Foundation

protocol MainMenuInteractorProtocol: AnyObject {
    
    var loadedMeals: Box<[Meal]> { get set }
    var loadedCategories: Box<[MealCategory]> { get set }
    //    var loadedMealDiscriptions: Box<[MealDiscription]> { get set }
    
    var networkService: NetworkServiceProtocol! { get set }    
    
    func getCountOfLoadedMeals() -> Int
    func getCountOfLoadedCategories() -> Int
    func categoryWasSelected(indexOfCategory: Int)
    func checkThatCategorySelectedAt(indexPath: IndexPath) -> Bool
    
    //NetworkService
    func startNetworkServiceForMainMenu()
}

class MainMenuInteractor: MainMenuInteractorProtocol {
    
    var loadedMeals = Box([Meal]())
    var loadedCategories = Box([MealCategory]())
    //    var loadedMealDiscriptions = Box([MealDiscription]())
    
    var networkService: NetworkServiceProtocol!
    weak var presenter: MainMenuPresenterProtocol!
    
    private var selectedCategory: Int = 0
    
    required init(presenter: MainMenuPresenterProtocol, networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        self.presenter = presenter
    }
    
    func getCountOfLoadedMeals() -> Int {
        return loadedMeals.value.count
    }
    
    func getCountOfLoadedCategories() -> Int {
        return loadedCategories.value.count
    }
    
    func categoryWasSelected(indexOfCategory: Int) {
        selectedCategory = indexOfCategory
        exequteRequest(with: .loadMeals)
    }
    
    func checkThatCategorySelectedAt(indexPath: IndexPath) -> Bool {
        let isSelected = loadedCategories.value[indexPath.item].strCategory == loadedCategories.value[selectedCategory].strCategory
        return isSelected
    }
    
    //MARK: - NetworkService
    
    func startNetworkServiceForMainMenu() {
        exequteRequest(with: .loadBanners)
        exequteRequest(with: .loadCategories)
        
    }
    
    private enum RequestType {
        case loadBanners
        case loadCategories
        case loadMeals
        
    }
    
    private func exequteRequest(with request: RequestType){
        switch request {
        case .loadBanners:
            getBannersFromMock()
        case .loadCategories:
            getListOfCategories()
        case .loadMeals:
            getMenuFromCategory()
        }
    }
    
    private func getBannersFromMock() {
        
    }
    
    private func getListOfCategories() {
        networkService.getCategoriesList { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let categories):
                    guard let categories = categories else {
                        return
                    }
                    self?.loadedCategories.value = categories.categories
                    self?.exequteRequest(with: .loadMeals)
                case .failure(let error):
                    print(error)
                }
            }
            
            
        }
    }
    
    private func getMenuFromCategory() {
        let category = loadedCategories.value[selectedCategory].strCategory
        networkService.getMealsFromCategory(category: category) { [weak self] result in
            DispatchQueue.main.async {
                
                
                switch result {
                case .success(let meals):
                    guard let meals = meals else {
                        return
                    }
                    self?.loadedMeals.value = meals.meals
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
