//
//  ProductModel.swift
//  RestaurantApp
//
//  Created by Иван Тиминский on 13.01.2022.
//

import Foundation


// MARK: - Meal
struct Meal: Codable {
    let strMeal: String
    let strMealThumb: String  
    let idMeal: String   // в связи с отсутвием цены у блюда - я подставлю id блюда вместо цены
}

// MARK: - Discription for meal
// в связи с отсутвием описания у блюда - я подставлю инструкцию по приготовлению вместо описания
struct MealDiscription: Codable {
    let strInstructions: String
}



// MARK: - Category list 
struct MealCategory: Codable {
    let idCategory: String
    let strCategory: String
//    let strCategoryThumb: String
//    let strCategoryDescription: String
}
