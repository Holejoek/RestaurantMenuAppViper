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
        configureShadowLayer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutConfiguration()
    }
    
    func configCellWithMealModel(with model: Meal) {
        self.mealName.text = model.strMeal
        //        self.mealDiscription.text = model.
        self.priceButton.setTitle(model.idMeal, for: .normal)
        
        //MARK: - SDWebImage
        guard let imageURL = URL(string: model.strMealThumb) else { return }

        self.mealThumbnail.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.mealThumbnail.sd_setImage(with: imageURL) { image, error, _, _ in
            if error != nil {
                self.mealThumbnail.image = UIImage(named: "notFound") ?? UIImage()
            }
            if image == nil {
                self.mealThumbnail.image = UIImage(named: "notFound") ?? UIImage()
            }
        }
    }
    private func layoutConfiguration(){
       
        mealThumbnail.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(20)
            make.left.equalTo(contentView).offset(20)
            make.width.equalTo(mealThumbnail.snp.height)
        }
        
        mealName.snp.makeConstraints { make in
            make.top.equalTo(mealThumbnail.snp.top)
            make.left.equalTo(mealThumbnail.snp.right).offset(20)
        }
        
        priceButton.snp.makeConstraints { make in
            make.right.equalTo(contentView.snp.right).offset(-20)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
     
    }
    
    private func configureShadowLayer() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.6
        self.layer.masksToBounds = false
    }
}

