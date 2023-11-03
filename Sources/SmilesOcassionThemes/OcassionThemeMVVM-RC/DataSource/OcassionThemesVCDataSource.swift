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

extension TableViewDataSource where Model == OfferDO {
    static func make(forNearbyOffers nearbyOffersObjects: [OfferDO], offerCellType: RestaurantsRevampTableViewCell.OfferCellType = .manCity,
                     reuseIdentifier: String = "RestaurantsRevampTableViewCell", data: String, isDummy: Bool = false, completion: ((Bool, String, IndexPath?) -> ())?) -> TableViewDataSource {
        return TableViewDataSource(
            models: nearbyOffersObjects,
            reuseIdentifier: reuseIdentifier,
            data: data,
            isDummy: isDummy
        ) { (offer, cell, data, indexPath) in
            guard let cell = cell as? RestaurantsRevampTableViewCell else { return }
            cell.configureCell(with: offer)
            cell.offerCellType = offerCellType
            cell.setBackGroundColor(color: UIColor(hexString: data))
            cell.favoriteCallback = { isFavorite, offerId in
                completion?(isFavorite, offerId, indexPath)
            }
        }
    }
}

extension TableViewDataSource where Model == BOGODetailsResponseLifestyleOffer {
    static func make(forSubscriptions subscriptions: [BOGODetailsResponseLifestyleOffer],
                     reuseIdentifier: String = String(describing: SmilesExplorerMembershipCardsTableViewCell.self), data: String, isDummy: Bool = false) -> TableViewDataSource {
        return TableViewDataSource(
            models: subscriptions,
            reuseIdentifier: reuseIdentifier,
            data: data,
            isDummy: isDummy
        ) { (subscription, cell, data, indexPath) in
            guard let cell = cell as? SmilesExplorerMembershipCardsTableViewCell else { return }
            cell.configureCell(with: subscription)
            cell.selectionStyle = .none
            cell.callBack = { () in
                //                cell.toggleButton.isSelected = !cell.toggleButton.isSelected
            }
            
            
            
        }
    }
}

extension TableViewDataSource where Model == OcassionThemesOfferResponse {
    static func make(forOffers collectionsObject: OcassionThemesOfferResponse,
                     reuseIdentifier: String = "SmilesExplorerHomeTicketsTableViewCell", data: String, isDummy: Bool = false, completion:((ExplorerOffer) -> ())?) -> TableViewDataSource {
        return TableViewDataSource(
            models: [collectionsObject].filter({$0.offers?.count ?? 0 > 0}),
            reuseIdentifier: reuseIdentifier,
            data : data,
            isDummy:isDummy
        ) { (offer, cell, data, indexPath) in
            guard let cell = cell as? SmilesExplorerHomeTicketsTableViewCell else {return}
            cell.collectionsData = offer.offers
            cell.setBackGroundColor(color: UIColor(hexString: data))
            cell.callBack = { offer in
                completion?(offer)
            }
        }
    }
}

extension TableViewDataSource where Model == OcassionThemesOfferResponse {
    static func make(forBogoHomeOffers collectionsObject: OcassionThemesOfferResponse,
                     reuseIdentifier: String = "SmilesExplorerHomeDealsAndOffersTVC", data: String, isDummy: Bool = false, completion:((ExplorerOffer) -> ())?) -> TableViewDataSource {
        return TableViewDataSource(
            models: [collectionsObject].filter({$0.offers?.count ?? 0 > 0}),
            reuseIdentifier: reuseIdentifier,
            data : data,
            isDummy:isDummy
        ) { (offer, cell, data, indexPath) in
            guard let cell = cell as? SmilesExplorerHomeDealsAndOffersTVC else {return}
            cell.collectionsData = offer.offers
            cell.setBackGroundColor(color: UIColor(hexString: data))
            cell.callBack = { offer in
                completion?(offer)
            }
        }
    }
}

extension TableViewDataSource where Model == OcassionThemesOfferResponse {
    static func make(forStories collectionsObject: OcassionThemesOfferResponse,
                     reuseIdentifier: String = "SmilesExplorerStoriesTVC", data : String, isDummy:Bool = false, onClick:((ExplorerOffer) -> ())?) -> TableViewDataSource {
        return TableViewDataSource(
            models: [collectionsObject].filter({$0.offers?.count ?? 0 > 0}),
            reuseIdentifier: reuseIdentifier,
            data: data,
            isDummy: isDummy
        ) { (storiesOffer, cell, data, indexPath) in
            guard let cell = cell as? SmilesExplorerStoriesTVC else {return}
            cell.collectionsData = storiesOffer.offers
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
extension TableViewDataSource where Model == SectionDetailDO {
    static func make(forUpgradeBanner collectionsObject: SectionDetailDO,
                     reuseIdentifier: String = "UpgradeBannerTVC", data : String, isDummy:Bool = false, onClick:((SectionDetailDO) -> ())?) -> TableViewDataSource {
        return TableViewDataSource(
            models: [collectionsObject].filter({$0.backgroundImage != nil}),
            reuseIdentifier: reuseIdentifier,
            data: data,
            isDummy: isDummy
        ) { (sectionDetail, cell, data, indexPath) in
            guard let cell = cell as? UpgradeBannerTVC else {return}
            cell.sectionData = sectionDetail
            
            
        }
    }
}



extension TableViewDataSource where Model == OfferDO {
    static func make(forBogoOffers offers: [OfferDO], offerCellType: RestaurantsRevampTableViewCell.OfferCellType = .smilesExplorer,
                     reuseIdentifier: String = "RestaurantsRevampTableViewCell", data: String, isDummy: Bool = false, completion: ((Bool, String, IndexPath?) -> ())?) -> TableViewDataSource {
        return TableViewDataSource(
            models: offers,
            reuseIdentifier: reuseIdentifier,
            data: data,
            isDummy: isDummy
        ) { (offer, cell, data, indexPath) in
            guard let cell = cell as? RestaurantsRevampTableViewCell else { return }
            cell.configureCell(with: offer)
            cell.offerCellType = offerCellType
            cell.selectionStyle = .none
            //            cell.setBackGroundColor(color: UIColor(hexString: data))
            cell.favoriteCallback = { isFavorite, offerId in
                completion?(isFavorite, offerId, indexPath)
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
