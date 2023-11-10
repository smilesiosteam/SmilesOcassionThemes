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
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        itemCategoriesDetails = try values.decodeIfPresent([ThemeCategoriesResponse].self, forKey: .itemCategoriesDetails)
        try super.init(from: decoder)
    }
}

public class ThemeCategoriesResponse: Codable {
    
    let categoryName: String?
    let animationURL: String?
    let redirectionURL: String?
    let backgroundColor: String?
    let prority: Int?
    let discountText: String?
    let subTitle: String?
    let foregroundImage: String?
    let titleColor: String?
    let backgroundImage: String?
    let categoryIconURL: String?
    let firebaseEventName: String?
    let title: String?
    let validTill: String?
    let headerText: String?
    let categoryID: Int?
    let themeID: Int?
    
    enum CodingKeys: String, CodingKey {
        case categoryName
        case animationURL = "animationUrl"
        case redirectionURL = "redirectionUrl"
        case backgroundColor
        case prority
        case discountText
        case subTitle
        case foregroundImage
        case titleColor
        case themeID = "themeId"
        case backgroundImage
        case categoryIconURL = "categoryIconUrl"
        case firebaseEventName
        case title
        case validTill
        case headerText = "header"
        case categoryID = "categoryId"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        categoryName = try container.decodeIfPresent(String.self, forKey: .categoryName)
        animationURL = try container.decodeIfPresent(String.self, forKey: .animationURL)
        redirectionURL = try container.decodeIfPresent(String.self, forKey: .redirectionURL)
        backgroundColor = try container.decodeIfPresent(String.self, forKey: .backgroundColor)
        prority = try container.decodeIfPresent(Int.self, forKey: .prority)
        discountText = try container.decodeIfPresent(String.self, forKey: .discountText)
        subTitle = try container.decodeIfPresent(String.self, forKey: .subTitle)
        foregroundImage = try container.decodeIfPresent(String.self, forKey: .foregroundImage)
        titleColor = try container.decodeIfPresent(String.self, forKey: .titleColor)
        themeID = try container.decodeIfPresent(Int.self, forKey: .themeID)
        backgroundImage = try container.decodeIfPresent(String.self, forKey: .backgroundImage)
        categoryIconURL = try container.decodeIfPresent(String.self, forKey: .categoryIconURL)
        firebaseEventName = try container.decodeIfPresent(String.self, forKey: .firebaseEventName)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        validTill = try container.decodeIfPresent(String.self, forKey: .validTill)
        headerText = try container.decodeIfPresent(String.self, forKey: .headerText)
        categoryID = try container.decodeIfPresent(Int.self, forKey: .categoryID)
    }
}
