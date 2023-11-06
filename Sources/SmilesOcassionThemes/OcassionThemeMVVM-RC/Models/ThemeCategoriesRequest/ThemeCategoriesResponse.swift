//
//  ThemeCategoriesResponse.swift
//
//
//  Created by Habib Rehman on 06/11/2023.
//

import Foundation

import Foundation
import SmilesBaseMainRequestManager

public struct ThemeCategoriesResponse: Codable {
    
    // MARK: - Model Variables
    
    var themeId: String?
    var categoryId: Int?
    var id: Int?
    var categoryName: String?
    var redirectionUrl: String?
    var categoryIconUrl: Int?
    var animationUrl: String?
    var backgroundImage: String?
    var foregroundImage:String?
    var firebaseEventName:String?
    var backgroundColor:String?
    var prority:Int?
    var headerText:String?
    var titleColor:String?
    var title:String?
    var discountText:String?
    var subTitle:String?
    var validTill:String?
    
    
    // MARK: - Model Keys
    public init (){}
    
    init(themeId: String? = nil, categoryId: Int? = nil, id: Int? = nil, categoryName: String? = nil, redirectionUrl: String? = nil, categoryIconUrl: Int? = nil, animationUrl: String? = nil, backgroundImage: String? = nil, foregroundImage: String? = nil, firebaseEventName: String? = nil, backgroundColor: String? = nil, prority: Int? = nil, headerText: String? = nil, titleColor: String? = nil, title: String? = nil, discountText: String? = nil, subTitle: String? = nil, validTill: String? = nil) {
        self.themeId = themeId
        self.categoryId = categoryId
        self.id = id
        self.categoryName = categoryName
        self.redirectionUrl = redirectionUrl
        self.categoryIconUrl = categoryIconUrl
        self.animationUrl = animationUrl
        self.backgroundImage = backgroundImage
        self.foregroundImage = foregroundImage
        self.firebaseEventName = firebaseEventName
        self.backgroundColor = backgroundColor
        self.prority = prority
        self.headerText = headerText
        self.titleColor = titleColor
        self.title = title
        self.discountText = discountText
        self.subTitle = subTitle
        self.validTill = validTill
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.themeId, forKey: .themeId)
        try container.encodeIfPresent(self.categoryId, forKey: .categoryId)
        try container.encodeIfPresent(self.id, forKey: .id)
        try container.encodeIfPresent(self.categoryName, forKey: .categoryName)
        try container.encodeIfPresent(self.redirectionUrl, forKey: .redirectionUrl)
        try container.encodeIfPresent(self.categoryIconUrl, forKey: .categoryIconUrl)
        try container.encodeIfPresent(self.animationUrl, forKey: .animationUrl)
        try container.encodeIfPresent(self.backgroundImage, forKey: .backgroundImage)
        try container.encodeIfPresent(self.foregroundImage, forKey: .foregroundImage)
        try container.encodeIfPresent(self.firebaseEventName, forKey: .firebaseEventName)
        try container.encodeIfPresent(self.backgroundColor, forKey: .backgroundColor)
        try container.encodeIfPresent(self.prority, forKey: .prority)
        try container.encodeIfPresent(self.headerText, forKey: .headerText)
        try container.encodeIfPresent(self.titleColor, forKey: .titleColor)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.discountText, forKey: .discountText)
        try container.encodeIfPresent(self.subTitle, forKey: .subTitle)
        try container.encodeIfPresent(self.validTill, forKey: .validTill)
    }
    
    enum CodingKeys: CodingKey {
        case themeId
        case categoryId
        case id
        case categoryName
        case redirectionUrl
        case categoryIconUrl
        case animationUrl
        case backgroundImage
        case foregroundImage
        case firebaseEventName
        case backgroundColor
        case prority
        case headerText
        case titleColor
        case title
        case discountText
        case subTitle
        case validTill
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.themeId = try container.decodeIfPresent(String.self, forKey: .themeId)
        self.categoryId = try container.decodeIfPresent(Int.self, forKey: .categoryId)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.categoryName = try container.decodeIfPresent(String.self, forKey: .categoryName)
        self.redirectionUrl = try container.decodeIfPresent(String.self, forKey: .redirectionUrl)
        self.categoryIconUrl = try container.decodeIfPresent(Int.self, forKey: .categoryIconUrl)
        self.animationUrl = try container.decodeIfPresent(String.self, forKey: .animationUrl)
        self.backgroundImage = try container.decodeIfPresent(String.self, forKey: .backgroundImage)
        self.foregroundImage = try container.decodeIfPresent(String.self, forKey: .foregroundImage)
        self.firebaseEventName = try container.decodeIfPresent(String.self, forKey: .firebaseEventName)
        self.backgroundColor = try container.decodeIfPresent(String.self, forKey: .backgroundColor)
        self.prority = try container.decodeIfPresent(Int.self, forKey: .prority)
        self.headerText = try container.decodeIfPresent(String.self, forKey: .headerText)
        self.titleColor = try container.decodeIfPresent(String.self, forKey: .titleColor)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.discountText = try container.decodeIfPresent(String.self, forKey: .discountText)
        self.subTitle = try container.decodeIfPresent(String.self, forKey: .subTitle)
        self.validTill = try container.decodeIfPresent(String.self, forKey: .validTill)
    }
    
    
    

    
    
}
