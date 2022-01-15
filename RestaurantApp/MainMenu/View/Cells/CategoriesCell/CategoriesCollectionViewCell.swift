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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configCellView()
    }
    
    func setupCell(with model: CategoryCellWithSelectedFlag ) {
        self.categoryLabel.text = model.category
        if model.isSelected {
            contentView.backgroundColor = UIColor.categoryCellColorIsSelected
        } else {
            contentView.backgroundColor = UIColor.categoryCellColorDefault
        }
    }
    
    private func configCellView() {
        layer.cornerRadius = 12
        layer.borderColor = UIColor.categoryCellBorderColor.cgColor
        layer.borderWidth = 0.5
    }
}
