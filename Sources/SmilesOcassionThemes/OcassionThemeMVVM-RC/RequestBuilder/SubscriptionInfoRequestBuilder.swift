//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 15/08/2023.
//


import NetworkingLayer

enum SubscriptionInfoRequestBuilder {
    
    case getSubscriptionInfo(request: SubscriptionInfoRequest)
    case getExclusiceOffer(request: OcassionThemesOfferRequest)
    
    // gave a default timeout but can be different for each.
    var requestTimeOut: Int {
        return 20
    }
    
    //specify the type of HTTP request
    var httpMethod: SmilesHTTPMethod {
        switch self {
        case .getSubscriptionInfo:
            return .POST
        case .getExclusiceOffer:
            return .POST
        }
    }
    
    // compose the NetworkRequest
    func createRequest(baseUrl: String, endpoint: SmilesExplorerEndpoints) -> NetworkRequest {
        var headers: [String: String] = [:]

        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
        headers["CUSTOM_HEADER"] = "pre_prod"
        
        return NetworkRequest(url: getURL(baseUrl: baseUrl, endPoints: endpoint), headers: headers, reqBody: requestBody, httpMethod: httpMethod)
    }
    
    // encodable request body for POST
    var requestBody: Encodable? {
        switch self {
        case .getSubscriptionInfo(let request):
            return request
        
        case .getExclusiceOffer(request: let request):
            return request
        }
    }
    
    // compose urls for each request
    func getURL(baseUrl: String, endPoints: SmilesExplorerEndpoints) -> String {
        switch self {
        case .getSubscriptionInfo:
            return baseUrl + endPoints.serviceEndPoints
        case .getExclusiceOffer:
            return baseUrl + endPoints.serviceEndPoints
        }
        
        
    }
}
