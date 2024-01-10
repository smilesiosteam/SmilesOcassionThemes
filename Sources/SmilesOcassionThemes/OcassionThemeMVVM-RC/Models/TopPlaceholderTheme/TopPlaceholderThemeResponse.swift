//
//  File.swift
//  
//
//  Created by Ghullam  Abbas on 07/11/2023.
//

import Foundation
import NetworkingLayer

class TopPlaceholderThemeResponse: BaseMainResponse {
    
    let themes: [TopPlaceholderTheme]?
    
    enum CodingKeys: String, CodingKey {
        case themes
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        themes = try values.decodeIfPresent([TopPlaceholderTheme].self, forKey: .themes)
        try super.init(from: decoder)
    }
    
}

struct TopPlaceholderTheme: Codable {
    
    var themeId: String?
    var header: String?
    var title: String?
    var discountText: String?
    var subText: String?
    var backgroundImage: String?
    var foregroundImage: String?
    var validTill: String?
    var backgroundColor: String?
    
}
