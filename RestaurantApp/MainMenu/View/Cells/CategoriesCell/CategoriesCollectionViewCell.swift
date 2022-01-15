//
//  CategoriesCollectionViewCell.swift
//  RestaurantApp
//
//  Created by Иван Тиминский on 15.01.2022.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoriesCollectionViewCell"
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //    override func prepareForReuse() {
    //        super.prepareForReuse()
    //        self.contentView.backgroundColor = .white
    //    }
    
    func setupCell(group: String, isSelected: Bool) {
        self.categoryLabel.text = group
        if isSelected {
            contentView.backgroundColor = .blue
        } else {
            contentView.backgroundColor = .white
        }
    }
}
