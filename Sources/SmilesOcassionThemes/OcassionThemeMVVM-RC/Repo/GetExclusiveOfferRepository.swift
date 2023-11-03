//
//  File.swift
//  
//
//  Created by Habib Rehman on 22/08/2023.
//


import Foundation
import Combine
import NetworkingLayer
import SmilesUtilities
import SmilesOffers

protocol OcassionThemesGetExclusiveOfferServiceable {
    func getExclusiveOffers(request: OcassionThemesOfferRequest) -> AnyPublisher<OcassionThemesOfferResponse, NetworkError>
    func getBogoOffers(request: OcassionThemesOfferRequest) -> AnyPublisher<OffersCategoryResponseModel, NetworkError>
    
}

// GetCuisinesRepository
class GetExclusiveOfferRepository: OcassionThemesGetExclusiveOfferServiceable {
    
    
    
    
    
    private var networkRequest: Requestable
    private var baseUrl: String
    private var endpoint: SmilesExplorerEndpoints
    

  // inject this for testability
    init(networkRequest: Requestable, baseUrl: String, endpoint: SmilesExplorerEndpoints) {
        self.networkRequest = networkRequest
        self.baseUrl = baseUrl
        self.endpoint = endpoint
        
    }
    
    func getExclusiveOffers(request: OcassionThemesOfferRequest) -> AnyPublisher<OcassionThemesOfferResponse, NetworkError> {
        
        let endPoint = SubscriptionInfoRequestBuilder.getExclusiceOffer(request: request)
        let request = endPoint.createRequest(baseUrl: baseUrl, endpoint: self.endpoint)
        return self.networkRequest.request(request)
        
    }
    
    func getBogoOffers(request: OcassionThemesOfferRequest) -> AnyPublisher<OffersCategoryResponseModel, NetworkError> {
        let endPoint = SubscriptionInfoRequestBuilder.getExclusiceOffer(request: request)
        let request = endPoint.createRequest(baseUrl: baseUrl, endpoint: self.endpoint)
        return self.networkRequest.request(request)
    }
}

