//
//  File.swift
//  
//
//  Created by Habib Rehman on 04/09/2023.
//

import Foundation
import SmilesSharedServices
import SmilesUtilities
import SmilesOffers
import SmilesBanners

extension OccasionThemesViewModel {
    
    public enum Input {
        case getSections(themeId: Int)
        case getStories(themeid: Int?, tag: SectionTypeTag, pageNo: Int?)
        case getTopBrands(categoryID: Int, menuItemType: String?)
        case getCollections(categoryID: Int, menuItemType: String?)
        case getTopOffers(menuItemType: String?, bannerType: String?, categoryId: Int?, bannerSubType: String?)
    }
    
    enum Output {
        
        case fetchSectionsDidSucceed(response: GetSectionsResponseModel)
        case fetchSectionsDidFail(error: Error)
        
        case fetchStoriesDidSucceed(response: ExplorerOfferResponse)
        case fetchStoriesDidFail(error: Error)
        
        case fetchTopBrandsDidSucceed(response: GetTopBrandsResponseModel)
        case fetchTopBrandsDidFail(error: Error)
        
//        case fetchCollectionsDidSucceed(response: GetCollectionsResponseModel)
//        case fetchCollectionDidFail(error: Error)
        
        case fetchTopOffersDidSucceed(response: GetTopOffersResponseModel)
        case fetchTopOffersDidFail(error: Error)
        
    }
    
}
