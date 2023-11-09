//
//  File.swift
//
//
//  Created by Abdul Rehman Amjad on 15/08/2023.
//


import NetworkingLayer

enum OcassionThemesRequestBuilder {
    case getThemeCategories(request: ThemeCategoriesRequest)
    case getThemesDetail(request: TopPlaceholderThemeRequest)
    
    // gave a default timeout but can be different for each.
    var requestTimeOut: Int {
        return 20
    }
    
    //specify the type of HTTP request
    var httpMethod: SmilesHTTPMethod {
        switch self {
        case .getThemeCategories:
            return .POST
        case.getThemesDetail:
            return .POST
        }
    }
    
    // compose the NetworkRequest
    func createRequest(baseUrl: String) -> NetworkRequest {
        var headers: [String: String] = [:]
        
        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
        headers["CUSTOM_HEADER"] = "pre_prod"
        
        return NetworkRequest(url: getURL(baseUrl: baseUrl), headers: headers, reqBody: requestBody, httpMethod: httpMethod)
    }
    
    // encodable request body for POST
    var requestBody: Encodable? {
        switch self {
            
        case .getThemeCategories(request: let request):
            return request
        case.getThemesDetail(request: let request):
            return request
        }
    }
    
    // compose urls for each request
    func getURL(baseUrl: String) -> String {
        switch self {
        case .getThemeCategories:
            return  baseUrl + "theme-occasion/get-theme-categories"
        case.getThemesDetail:
            return baseUrl + "theme-occasion/get-theme-details"
        }
        
        
    }
}
