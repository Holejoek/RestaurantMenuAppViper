//
//  BannerCollectionViewCell.swift
//  RestaurantApp
//
//  Created by Иван Тиминский on 14.01.2022.
//

import Foundation
import UIKit


class BannerCollectionViewCell: UICollectionViewCell {
    static let identifier = "BannerCollectionCell" 
    
    @IBOutlet weak var bannerImage: UIImageView!

    override class func awakeFromNib() {
        super .awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        configImage()
    }
    
    private func configImage() {
        bannerImage.contentMode = .scaleAspectFill
        bannerImage.layer.cornerRadius = 10
    }
}

