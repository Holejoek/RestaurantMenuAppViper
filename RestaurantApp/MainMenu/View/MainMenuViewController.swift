//
//  View.swift
//  RestaurantApp
//
//  Created by Иван Тиминский on 13.01.2022.
//

import Foundation
import UIKit


protocol MainMenuViewProtocol: AnyObject {
    var presenter: MainMenuPresenterProtocol! { get set }
    
    func updateCellsForSection(section: Int)
    func updateCategoriesCollectionView()
    func showError(with: Error)
}


class MainMenuViewController: UIViewController, MainMenuViewProtocol {
    
    var presenter: MainMenuPresenterProtocol!
    
    lazy var mainMenuTableView: UITableView = makeTableView()
    lazy var categoriesCollectionView: UICollectionView = makeCategoriesCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        presenter.notifyThatViewDidLoad()
    }
    
    //MARK: - Methods
    func updateCellsForSection(section: Int) {
        mainMenuTableView.reloadSections([section], with: .none)
    }
    
    func updateCategoriesCollectionView() {
        categoriesCollectionView.reloadData()
    }
    
    func showError(with: Error) {
        
    }
    
    func showActivityIndicator(isActive: Bool) {
        
    }
    
    //MARK: - Private methods
    private func configureViewController() {
        navigationItem.title = "Приятного аппетита!"
        view.backgroundColor = .white
    }
    
    private func makeTableView() -> UITableView {
        let tableView = UITableView(frame: view.bounds)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = .white
        
        tableView.register(BannerTableViewCell.self, forCellReuseIdentifier: BannerTableViewCell.identifier)
        tableView.register(UINib(nibName: "MealCell", bundle: nil), forCellReuseIdentifier: MealCell.identifier)
        
        view.addSubview(tableView)
        return tableView
    }
    
    private func makeCategoriesCollectionView() -> UICollectionView {
        let layer = UICollectionViewFlowLayout()
        layer.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layer)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        
        return collectionView
    }
}

// MARK: - MainMenuTableView extension
extension MainMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK:  UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  presenter.getNumberOfRows(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = mainMenuTableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.identifier, for: indexPath) as! BannerTableViewCell
            cell.backgroundColor = .green
            return cell
        } else if indexPath.section == 1 {
            let mealInfo: Meal = presenter.getMealInfo(for: indexPath)
            let mealDiscription: String = presenter.getMealDiscription(for: indexPath)
            
            let cell = mainMenuTableView.dequeueReusableCell(withIdentifier: MealCell.identifier, for: indexPath) as! MealCell
            cell.configCellWithMealModel(with: mealInfo)
            return cell
        }
        return UITableViewCell()
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        presenter.getHeightForRowAt(for: indexPath, heighOfView: view.frame.height)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        presenter.getHeightForHeader(for: section, heightOfView: view.frame.height)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            return categoriesCollectionView
        default:
            return nil
        }
    }
}


// MARK: - CategoriesCollectionView extension
extension MainMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getNumberOfCategories()
    }
    //MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let category = presenter.getMealCategory(for: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
        cell.setupCell(group: category, isSelected: false)
        
        return cell
    }
    
    
    //MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let category = presenter.getMealCategory(for: indexPath)
        let width = category.widthOfString(usingFont: UIFont.systemFont(ofSize: 17)) 
        return CGSize(width: width + 20 , height:  collectionView.frame.height )
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return 10
    //    }
    //    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    //    }
    //    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        return 10 // для груп
    //    }
}

