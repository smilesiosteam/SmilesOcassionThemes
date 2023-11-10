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
    var n:Int = 0
    
    // MARK: - Cell Configuration
    var collectionsData: [ThemeCategoriesResponse]?{
        didSet{
            print("Coellections Count is:",collectionsData?.count ?? 0)
            self.n = collectionsData?.count ?? 0
            self.collectionView?.reloadData()
            let height = collectionView.collectionViewLayout.collectionViewContentSize.height
            self.heightConstant.constant = height
            
        }
    }
    
    // this property will return if we are following even model or Odd.
    var isEven: Bool {
        
        if let categoryCount = collectionsData {
            return categoryCount.count%2 == 0 ? true:false
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
        return isEven == true ? 1:2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if self.isEven == true {
            return self.collectionsData?.count ?? 0
        }else{
            switch section {
            case 0:
                return 1
            case 1:
                return (self.collectionsData?.count ?? 0)-1
            default:
                break
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let category = collectionsData?[indexPath.row] {
            if self.isEven == true {
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopByCategoriesCVC", for: indexPath) as? ShopByCategoriesCVC else {return UICollectionViewCell()}
                cell.categories = category
                return cell
                
            }else{
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
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if self.isEven == true {
            return CGSize(width: collectionView.frame.width/2.2-8, height: 230)
        }else{
            switch indexPath.section {
            case 0:
                return CGSize(width: collectionView.frame.width-8, height: 140)
            case 1:
                return CGSize(width: collectionView.frame.width/2.2-8, height: 230)
            default:
                break
            }
        }
        
        return CGSize(width: 0.0, height: 0.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if self.isEven == true {
            return 0
        } else {
            switch section {
            case 0:
                return 0
            case 1:
                return 8
            default:
                break
            }
        }
        return 0
        
    }
    // Cell Margin
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//            if self.isEven == true {
//                return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
//            } else {
//                switch section {
//                case 0:
//                    return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
//                case 1:
//                    return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
//                default:
//                    break
//                }
//            }
            return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        }
    
    
}
