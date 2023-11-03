//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 04/09/2023.
//

import Foundation
import SmilesUtilities

enum OccasionThemesSectionIdentifier: String,SectionIdentifierProtocol {
    
    var identifier: String { return self.rawValue}
    case topPlaceholder = "THEME_TOP_PLACEHOLDER"
    case themeItemCategories = "THEME_ITEM_CATEGORIES"
    case stories = "STORIES"
    case topCollections = "TOP_COLLECTIONS"
    case topBrands = "TOP_BRANDS"
    
}

struct OccasionThemesSectionData {
    
    let index: Int
    let identifier: OccasionThemesSectionIdentifier
    
}
