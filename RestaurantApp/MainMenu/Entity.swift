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
    let idMeal: String
    
    var priceFromId: String {  // в связи с отсутвием цены у блюда по данному API - я подставлю id блюда вместо цены
        let doubleId = Double(idMeal) ?? 50000
        let price = doubleId / 100
        return String(price)
    }
}

// MARK: - Category list 
struct MealCategory: Codable {
    let idCategory: String
    let strCategory: String
}

//MARK: Передача isSelected вместе с категориейПродукта
typealias CategoryCellWithSelectedFlag = (category: String, isSelected: Bool)
