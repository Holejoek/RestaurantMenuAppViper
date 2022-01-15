//
//  Box.swift
//  RestaurantApp
//
//  Created by Иван Тиминский on 13.01.2022.
//

import Foundation


class Box<T> {
    typealias Listener = (T) -> Void
    
    var listener: Listener?
    
    var value: T! {
        didSet {
            listener?(value)
        }
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        self.listener?(value)
    }
    
    init(_ value: T){
        self.value = value
    }
}

