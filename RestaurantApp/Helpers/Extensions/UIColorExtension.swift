//
//  UIColorExtension.swift
//  RestaurantApp
//
//  Created by Иван Тиминский on 15.01.2022.
//

import Foundation
import UIKit


extension UIColor {
    //MARK: - Background
    //запас
    static var firstMainBack: UIColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    static var secondMainBack: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    //MARK: - CategoryCell
    //Цвет границ
    static var categoryCellBorderColor: UIColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    //Цвет фона
    static var categoryCellColorDefault: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static var categoryCellColorIsSelected: UIColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
}
