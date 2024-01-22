//
//  ShopByCategoriesTVC.swift
//
//
//  Created by Habib Rehman on 30/10/2023.
//

import UIKit
import SmilesUtilities

class ShopByCategoriesTVC: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var heightConstant: NSLayoutConstraint!
    
    // MARK: - Properties
    private var numberOfItems:Int = 0
    var callBack: ((ThemeCategoriesResponse) -> ())?
    
    // MARK: - Cell Configuration
    var collectionsData: [ThemeCategoriesResponse]?{
        didSet{
            print("Coellections Count is:",collectionsData?.count ?? 0)
            self.numberOfItems = collectionsData?.count ?? 0
            self.collectionView?.reloadData()
            let height = collectionView.collectionViewLayout.collectionViewContentSize.height
            self.heightConstant.constant = height
            
        }
    }
    
    // this property will return if we are following even model or Odd.
    private var isEven: Bool {
        if let categoryCount = collectionsData {
            return categoryCount.count % 2 == 0
        }
        return false
    }
    
    // MARK: - SuperCell Properties
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionViewSetup()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // MARK: - cellUISetup
    private func collectionViewSetup(){
        
        //CollectionView Setup
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: String(describing: ShopByCategoriesCVC.self), bundle: .module), forCellWithReuseIdentifier: String(describing: ShopByCategoriesCVC.self))
        self.collectionView.register(UINib(nibName: String(describing: CategoriesCardCVC.self), bundle: .module), forCellWithReuseIdentifier: String(describing: CategoriesCardCVC.self))
        let height = collectionView.collectionViewLayout.collectionViewContentSize.height
        self.heightConstant.constant = height
        
    }
    
}


extension ShopByCategoriesTVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return isEven ? 1 : 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isEven {
            return collectionsData?.count ?? 0
        } else {
            switch section {
            case 0:
                return 1
            case 1:
                return (collectionsData?.count ?? 0) - 1
            default:
                break
            }
        }
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let category = collectionsData?[indexPath.row] {
            if isEven {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopByCategoriesCVC", for: indexPath) as? ShopByCategoriesCVC else {return UICollectionViewCell()}
                cell.categories = category

                return cell
            } else {
                switch indexPath.section {
                case 0:
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCardCVC", for: indexPath) as? CategoriesCardCVC else {return UICollectionViewCell()}
                    if let category = collectionsData {
                        cell.category = category.first
                    }
                    return cell
                case 1:
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopByCategoriesCVC", for: indexPath) as? ShopByCategoriesCVC else {return UICollectionViewCell()}
                    if let categoryObject =  collectionsData?[indexPath.row + 1] {
                        cell.categories = categoryObject

                    }
                    return cell
                default:
                    break
                }
            }
        }
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isEven {
            if let category = collectionsData?[indexPath.row] {
                self.callBack?(category)
            }
        } else{
            switch indexPath.section {
            case 0:
                if let category = collectionsData?[indexPath.section] {
                    self.callBack?(category)
                }
            case 1:
                if let category = collectionsData?[indexPath.row+1] {
                    self.callBack?(category)
                }
            default:
                break
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if isEven {
            let width = (collectionView.frame.width - 15) / 2
            return CGSize(width: width, height: width * 1.4)
        } else {
            switch indexPath.section {
            case 0:
                let width = collectionView.frame.width
                return CGSize(width: width, height: width * 0.4)
            case 1:
                let width = (collectionView.frame.width - 15) / 2
                return CGSize(width: width, height: width * 1.4)
            default:
                break
            }
        }
        return CGSize(width: 0.0, height: 0.0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        if isEven {
            return 15
        } else {
            switch section {
            case 0:
                return 0
            case 1:
                return 15
            default:
                break
            }
        }
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if !isEven && section == 1 {
            return UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
}
