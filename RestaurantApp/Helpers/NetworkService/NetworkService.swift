//
//  NetworkService.swift
//  RestaurantApp
//
//  Created by Иван Тиминский on 13.01.2022.
//

import Foundation


protocol NetworkServiceProtocol {
    
    func getCategoriesList(completion: @escaping (Result<ListOfCategoiesModel?, Error>) -> Void)
    func getMealsFromCategory(category: String, completion: @escaping (Result<MealsFromCategoryModel?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    
    enum TheMealDBAPIPath: String {
        case base = "https://www.themealdb.com/api/json/v1"
        case apiKey = "/1"
        //options
        case getCategoriesList = "/categories.php"
        case getMealsFromCategory = "/filter.php?c="
        case getFullMealById = "/lookup.php?i="
    }
    
    func getCategoriesList(completion: @escaping (Result<ListOfCategoiesModel?, Error>) -> Void) {
        
        let urlString = TheMealDBAPIPath.base.rawValue + TheMealDBAPIPath.apiKey.rawValue + TheMealDBAPIPath.getCategoriesList.rawValue
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let obj = try JSONDecoder().decode(ListOfCategoiesModel.self, from: data!)
                completion(.success((obj)))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getMealsFromCategory(category: String, completion: @escaping (Result<MealsFromCategoryModel?, Error>) -> Void) {
        
        let urlString = TheMealDBAPIPath.base.rawValue + TheMealDBAPIPath.apiKey.rawValue + TheMealDBAPIPath.getMealsFromCategory.rawValue + category
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let obj = try JSONDecoder().decode(MealsFromCategoryModel.self, from: data!)
                completion(.success((obj)))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
