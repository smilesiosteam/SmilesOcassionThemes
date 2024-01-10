//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 15/08/2023.
//

import Foundation
import SmilesUtilities
import SmilesSharedServices
import UIKit
import SmilesOffers
import SmilesBanners
import SmilesStoriesManager

extension TableViewDataSource where Model == ItemCategoriesDetailsResponse {
    static func make(forItemCategories collectionsObject: ItemCategoriesDetailsResponse,
                     reuseIdentifier: String = "ShopByCategoriesTVC", data : String, isDummy:Bool = false, onClick:((ThemeCategoriesResponse) -> ())?) -> TableViewDataSource {
        return TableViewDataSource(
            models: [collectionsObject].filter({$0.itemCategoriesDetails?.count ?? 0 > 0}),
            reuseIdentifier: reuseIdentifier,
            data: data,
            isDummy: isDummy
        ) { (categories, cell, data, indexPath) in
            guard let cell = cell as? ShopByCategoriesTVC else {return}
            cell.collectionsData = categories.itemCategoriesDetails
            //cell.setBackGroundColor(color: UIColor(hexString: data))
            cell.callBack = { data in
                debugPrint(data)
                onClick?(data)
            }
        }
    }
}


extension TableViewDataSource where Model == Stories {
    static func make(forStories collectionsObject: Stories,
                     reuseIdentifier: String = "StoriesTableViewCell", data : String, isDummy:Bool = false, onClick:((Story) -> ())?) -> TableViewDataSource {
        return TableViewDataSource(
            models: [collectionsObject].filter({$0.stories?.count ?? 0 > 0}),
            reuseIdentifier: reuseIdentifier,
            data: data,
            isDummy: isDummy
        ) { (stories, cell, data, indexPath) in
            guard let cell = cell as? StoriesTableViewCell else {return}
            cell.collectionsData = stories.stories
            cell.setBackGroundColor(color: UIColor(hexString: data))
            cell.callBack = { data in
                      debugPrint(data)
                onClick?(data)
            }
        }
    }
}

extension TableViewDataSource where Model == GetTopBrandsResponseModel {
    static func make(forBrands collectionsObject: GetTopBrandsResponseModel,
                     reuseIdentifier: String = "TopBrandsTableViewCell", data: String, isDummy: Bool = false, topBrandsType: TopBrandsTableViewCell.TopBrandsType, completion:((GetTopBrandsResponseModel.BrandDO) -> ())?) -> TableViewDataSource {
        return TableViewDataSource(
            models: [collectionsObject].filter({$0.brands?.count ?? 0 > 0}),
            reuseIdentifier: reuseIdentifier,
            data : data,
            isDummy:isDummy
        ) { (topBrands, cell, data, indexPath) in
            guard let cell = cell as? TopBrandsTableViewCell else {return}
            cell.collectionsDataTopBrand = topBrands.brands
            cell.setBackGroundColor(color: UIColor(hexString: data))
            cell.topBrandsType = topBrandsType
            cell.callBack = { brand in
                completion?(brand)
            }
        }
    }
}

extension TableViewDataSource where Model == GetCollectionsResponseModel {
    static func make(forCollections collectionsObject: GetCollectionsResponseModel,
                     reuseIdentifier: String = "CollectionsTableViewCell", data : String, isDummy:Bool = false, completion:((GetCollectionsResponseModel.CollectionDO) -> ())?) -> TableViewDataSource {
        return TableViewDataSource(
            models: [collectionsObject].filter{$0.collections?.count ?? 0 > 0},
            reuseIdentifier: reuseIdentifier,
            data:data,
            isDummy:isDummy
        ) { (collection, cell, data, indexPath) in
            guard let cell = cell as? CollectionsTableViewCell else {return}
            cell.collectionsData = collection.collections
            cell.setBackGroundColor(color: UIColor(hexString: data))
            cell.callBack = { collection in
                completion?(collection)
            }
        }
    }
}


