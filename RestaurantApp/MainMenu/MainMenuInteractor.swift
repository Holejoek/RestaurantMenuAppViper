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
    
    //NetworkService
    func startNetworkServiceForMainMenu()
    func getMealDiscriptions(for indexPath: IndexPath) -> String

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
    }
    
    //MARK: - NetworkService
    
    func startNetworkServiceForMainMenu() {
        exequteRequest(with: .loadBanners)
        exequteRequest(with: .loadCategories)
        
    }
    
    func getMealDiscriptions(for indexPath: IndexPath) -> String {
        var mealDiscription: String = ""
        let mealId: String = loadedMeals.value[indexPath.row].idMeal
        
        networkService.getFullMealById(id: mealId) { result in    // [weak self] если понадобится
            //  Возможно здесь понадобится семафор для того чтобы возвращался не путой mealDiscription
            DispatchQueue.main.async {
                
                switch result {
                case .success(let discription):
                    guard let discription = discription?.meals.first?.strInstructions else {
                        return
                    }
                    mealDiscription = discription
                case .failure(let error):
                    print(error)
                }
            }
        }
        return mealDiscription
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
