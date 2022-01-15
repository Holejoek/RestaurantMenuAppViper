//
//  StringExtension.swift
//  RestaurantApp
//
//  Created by Иван Тиминский on 15.01.2022.
//

import Foundation
import CoreGraphics
import UIKit


extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: fontAttributes)
        return ceil(size.width)
    }
}
