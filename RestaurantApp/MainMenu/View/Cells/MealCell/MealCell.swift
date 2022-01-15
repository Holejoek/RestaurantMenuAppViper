//
//  ProductCell.swift
//  RestaurantApp
//
//  Created by Иван Тиминский on 13.01.2022.
//

import Foundation
import UIKit
import SDWebImage
import SnapKit


class MealCell: UITableViewCell {
    static var identifier = "MealCell"
    
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealThumbnail: UIImageView!
    @IBOutlet weak var mealDiscription: UILabel!
    @IBOutlet weak var priceButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutConfiguration()
        elementsConfiguration()
    }
    
    func configCellWithMealModel(with model: Meal, and discriptionExample: String) {
        mealName.text = model.strMeal
        mealDiscription.text = discriptionExample
        priceButton.setTitle(model.priceFromId, for: .normal)
        
        //MARK: - SDWebImage
        guard let imageURL = URL(string: model.strMealThumb) else { return }
        
        mealThumbnail.sd_imageIndicator = SDWebImageActivityIndicator.gray
        mealThumbnail.sd_setImage(with: imageURL) { image, error, _, _ in
            if error != nil {
                self.mealThumbnail.image = UIImage(named: "notFound") ?? UIImage()
            }
            if image == nil {
                self.mealThumbnail.image = UIImage(named: "notFound") ?? UIImage()
            }
        }
    }
    
    //MARK: Constraints SnapKit
    private func layoutConfiguration(){
        
        mealThumbnail.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(20)
            make.left.equalTo(contentView).offset(20)
            make.width.equalTo(mealThumbnail.snp.height)
        }
        
        mealName.snp.makeConstraints { make in
            make.top.equalTo(mealThumbnail.snp.top)
            make.left.equalTo(mealThumbnail.snp.right).offset(20)
            make.right.equalTo(contentView.snp.right).offset(-20)
        }
        
        priceButton.snp.makeConstraints { make in
            make.right.equalTo(contentView.snp.right).offset(-20)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
        
        mealDiscription.snp.makeConstraints { make in
            make.top.equalTo(mealName.snp.bottom).offset(15)
            make.left.equalTo(mealName.snp.left)
            make.right.equalTo(contentView.snp.right).offset(-20)
            make.bottom.equalTo(priceButton.snp.top).offset(-15)
        }
    }
    private func elementsConfiguration(){
        mealDiscription.numberOfLines = 0
        mealDiscription.textColor = .systemGray
        mealDiscription.textAlignment = .left
        
        mealThumbnail.layer.cornerRadius = 6
        
        mealName.textAlignment = .left
        
        priceButton.layer.cornerRadius = 5
        priceButton.layer.borderWidth = 1
        priceButton.layer.borderColor = UIColor.categoryCellBorderColor.cgColor
    }
}

