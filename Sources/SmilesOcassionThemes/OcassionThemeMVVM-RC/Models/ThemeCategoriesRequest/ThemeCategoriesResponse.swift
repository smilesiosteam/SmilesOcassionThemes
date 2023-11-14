//
//  ThemeCategoriesResponse.swift
//
//
//  Created by Habib Rehman on 06/11/2023.
//
import Foundation
import NetworkingLayer


class ItemCategoriesDetailsResponse: BaseMainResponse {
    
    var itemCategoriesDetails: [ThemeCategoriesResponse]?
    
    enum CodingKeys: String, CodingKey {
        case itemCategoriesDetails
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        itemCategoriesDetails = try values.decodeIfPresent([ThemeCategoriesResponse].self, forKey: .itemCategoriesDetails)
        try super.init(from: decoder)
    }
    
}

class ThemeCategoriesResponse: Codable {
    
    let themeId: Int?
    let categoryId: Int?
    let id: Int?
    let categoryName: String?
    let redirectionUrl: String?
    let categoryIconUrl: String?
    let animationUrl: String?
    let backgroundImage: String?
    let foregroundImage: String?
    let firebaseEventName: String?
    let prority: Int?
    let headerText: String?
    let headerColor: String?
    let backgroundColor: String?
    let title: String?
    let discountText: String?
    let subTitle: String?
    let validTill: String?
    
    enum CodingKeys: String, CodingKey {
        case categoryName
        case animationUrl
        case redirectionUrl
        case backgroundColor
        case prority
        case discountText
        case subTitle
        case foregroundImage
        case headerColor
        case themeId
        case backgroundImage
        case categoryIconUrl
        case firebaseEventName
        case title
        case validTill
        case headerText
        case categoryId
        case id
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        categoryName = try container.decodeIfPresent(String.self, forKey: .categoryName)
        animationUrl = try container.decodeIfPresent(String.self, forKey: .animationUrl)
        redirectionUrl = try container.decodeIfPresent(String.self, forKey: .redirectionUrl)
        backgroundColor = try container.decodeIfPresent(String.self, forKey: .backgroundColor)
        prority = try container.decodeIfPresent(Int.self, forKey: .prority)
        discountText = try container.decodeIfPresent(String.self, forKey: .discountText)
        subTitle = try container.decodeIfPresent(String.self, forKey: .subTitle)
        foregroundImage = try container.decodeIfPresent(String.self, forKey: .foregroundImage)
        headerColor = try container.decodeIfPresent(String.self, forKey: .headerColor)
        themeId = try container.decodeIfPresent(Int.self, forKey: .themeId)
        backgroundImage = try container.decodeIfPresent(String.self, forKey: .backgroundImage)
        categoryIconUrl = try container.decodeIfPresent(String.self, forKey: .categoryIconUrl)
        firebaseEventName = try container.decodeIfPresent(String.self, forKey: .firebaseEventName)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        validTill = try container.decodeIfPresent(String.self, forKey: .validTill)
        headerText = try container.decodeIfPresent(String.self, forKey: .headerText)
        categoryId = try container.decodeIfPresent(Int.self, forKey: .categoryId)
    }
    
}
