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

public class ThemeCategoriesResponse : Codable {
    let id: Int?
    let categoryName: String?
    let animationURL: String?
    let redirectionURL, backgroundColor: String?
    let prority: Int?
    let discountText, subTitle: String?
    let foregroundImage: String?
    let titleColor, themeID: String?
    let backgroundImage, categoryIconURL: String?
    let firebaseEventName, title, validTill, headerText: String?
    let categoryID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, categoryName
        case animationURL = "animationUrl"
        case redirectionURL = "redirectionUrl"
        case backgroundColor, prority, discountText, subTitle, foregroundImage, titleColor
        case themeID = "themeId"
        case backgroundImage
        case categoryIconURL = "categoryIconUrl"
        case firebaseEventName, title, validTill, headerText
        case categoryID = "categoryId"
    }
}


