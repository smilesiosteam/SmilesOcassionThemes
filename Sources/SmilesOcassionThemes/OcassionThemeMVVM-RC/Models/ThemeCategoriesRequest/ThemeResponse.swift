//
//  File.swift
//  
//
//  Created by Ghullam  Abbas on 07/11/2023.
//

import Foundation
import SmilesBaseMainRequestManager

public struct ThemeResponse: Codable {
    
    // MARK: - Model Variables
    var themeId: String?
    var header: String?
    var title: String?
    var discountText: String?
    var subText: String?
    var backgroundImage: String?
    var foregroundImage: String?
    var validTill: String?
    
    // MARK: - Model Keys
    public init (){}
    
    init(themeId: String? = nil, header: String? = nil, title: String? = nil, discountText: String? = nil, subText: String? = nil, backgroundImage: String? = nil, foregroundImage: String? = nil, validTill: String? = nil) {
        
        self.themeId = themeId
        self.header = header
        self.title = title
        self.discountText = discountText
        self.subText = subText
        self.backgroundImage = backgroundImage
        self.foregroundImage = foregroundImage
        self.validTill = validTill
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.themeId, forKey: .themeId)
        try container.encodeIfPresent(self.header, forKey: .header)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.discountText, forKey: .discountText)
        try container.encodeIfPresent(self.subText, forKey: .subText)
        try container.encodeIfPresent(self.backgroundImage, forKey: .backgroundImage)
        try container.encodeIfPresent(self.foregroundImage, forKey: .foregroundImage)
        try container.encodeIfPresent(self.validTill, forKey: .validTill)
    }
    
    enum CodingKeys: CodingKey {
        
        case themeId
        case backgroundImage
        case foregroundImage
        case header
        case title
        case discountText
        case subText
        case validTill
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.discountText = try container.decodeIfPresent(String.self, forKey: .discountText)
        self.themeId = try container.decodeIfPresent(String.self, forKey: .themeId)
        self.backgroundImage = try container.decodeIfPresent(String.self, forKey: .backgroundImage)
        self.foregroundImage = try container.decodeIfPresent(String.self, forKey: .foregroundImage)
        self.header = try container.decodeIfPresent(String.self, forKey: .header)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.subText = try container.decodeIfPresent(String.self, forKey: .subText)
        self.validTill = try container.decodeIfPresent(String.self, forKey: .validTill)
    }
}

public struct ThemeResponseModel: Codable {
    
    public let themes: [ThemeResponse]?
}
