//
//  BannerCell.swift
//  RestaurantApp
//
//  Created by Иван Тиминский on 14.01.2022.
//

import Foundation
import UIKit

class BannerTableViewCell: UITableViewCell {
    static var identifier = "BannerCell"
    
    var banersImageArray = [UIImage]()
    lazy var bannerCollectionView: UICollectionView = createBannerColletionView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        banersImageArray.append(UIImage(named: "banner1")!)
        banersImageArray.append(UIImage(named: "banner2")!)
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
    }
    
    private func createBannerColletionView() -> UICollectionView {
        
        let layer = UICollectionViewFlowLayout()
        layer.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: contentView.frame, collectionViewLayout: layer)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true // Можно попробовать (желательно) сделать чтоб баннер автоматически пролистывался
        collectionView.register(UINib(nibName: "BannerCollectionCell", bundle: nil), forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        
        addSubview(collectionView)
        return collectionView
    }
    
}

//MARK: - Extension
extension BannerTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let image = banersImageArray[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as! BannerCollectionViewCell
        cell.bannerImage.image = image
        return cell
        
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = contentView.frame.height
        let width = contentView.frame.width - 40
        let size = CGSize(width: width, height: height)
        return size
    }
}
