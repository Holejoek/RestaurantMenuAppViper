//
//  NetworkServiceModel.swift
//  RestaurantApp
//
//  Created by Иван Тиминский on 13.01.2022.
//

import Foundation


// MARK: - Available categories list request
struct ListOfCategoiesModel: Codable {
    let categories: [MealCategory]
}

// MARK: -  Discription request
struct DiscriptionMealModel: Codable {
    let meals: [MealDiscription]
}

// MARK: -  Category request
struct MealsFromCategoryModel: Codable {
    let meals: [Meal]
}
