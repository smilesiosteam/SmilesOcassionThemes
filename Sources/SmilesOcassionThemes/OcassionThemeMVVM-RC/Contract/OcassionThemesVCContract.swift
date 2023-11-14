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
    
    enum Input {
        case getSections(themeId: Int)
        case getStories(themeid: Int?, pageNo: Int?)
        case getTopBrands(themeId: Int?, menuItemType: String?)
        case getCollections(themeId: Int?, menuItemType: String?)
        case getThemeCategories(themeId: Int?)
        case getThemesDetail(themeId: Int?)
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
        
        case fetchThemeCategoriesDidSucceed(response: ItemCategoriesDetailsResponse)
        case fetchThemeCategoriesDidFail(error: Error)
        
        case fetchThemeDetailDidSucceed(response: TopPlaceholderThemeResponse)
        case fetchThemeDetailDidFail(error: Error)
        
    }
    
}
