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
    }
    
    enum Output {
        
        case fetchSectionsDidSucceed(response: GetSectionsResponseModel)
        case fetchSectionsDidFail(error: Error)
        
        case fetchStoriesDidSucceed(response: OcassionThemesOfferResponse)
        case fetchStoriesDidFail(error: Error)
        

        
    }
    
}
