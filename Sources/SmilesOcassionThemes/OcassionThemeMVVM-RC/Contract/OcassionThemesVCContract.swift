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
import SmilesStoriesManager

extension OccasionThemesViewModel {
    
    public enum Input {
        case getSections(themeId: Int)
        case getStories(themeid: Int?, pageNo: Int?)
        case getTopBrands(themeId: Int?, menuItemType: String?)
        case getCollections(themeId: Int?, menuItemType: String?)
    }
    
    enum Output {
        
        case fetchSectionsDidSucceed(response: GetSectionsResponseModel)
        case fetchSectionsDidFail(error: Error)
        
        case fetchStoriesDidSucceed(response: Stories)
        case fetchStoriesDidFail(error: Error)
        
        case fetchTopBrandsDidSucceed(response: GetTopBrandsResponseModel)
        case fetchTopBrandsDidFail(error: Error)
        
        case fetchCollectionsDidSucceed(response: GetCollectionsResponseModel)
        case fetchCollectionDidFail(error: Error)
        
    }
    
}
