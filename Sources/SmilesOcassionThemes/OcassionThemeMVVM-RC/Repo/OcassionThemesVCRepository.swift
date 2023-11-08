//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 15/08/2023.
//

import Foundation
import Combine
import NetworkingLayer
import SmilesUtilities

protocol OcassionThemesServiceable {
    func getThemeCategoriesService(request: ThemeCategoriesRequest) -> AnyPublisher<ThemeCategoriesResponse, NetworkError>
    func getThemeDetailService(request: ThemeCategoriesRequest) -> AnyPublisher<ThemeResponseModel, NetworkError>
}


class OcassionThemesRepository: OcassionThemesServiceable {
    func getThemeDetailService(request: ThemeCategoriesRequest) -> AnyPublisher<ThemeResponseModel, NetworkingLayer.NetworkError> {
        let endPoint = OcassionThemesRequestBuilder.getThemesDetail(request: request)
        let request = endPoint.createRequest(baseUrl: baseUrl)
        return self.networkRequest.request(request)
    }
    
    
    func getThemeCategoriesService(request: ThemeCategoriesRequest) -> AnyPublisher<ThemeCategoriesResponse, NetworkingLayer.NetworkError> {
        let endPoint = OcassionThemesRequestBuilder.getThemeCategories(request: request)
        let request = endPoint.createRequest(baseUrl: baseUrl)
        return self.networkRequest.request(request)
    }
    
    private var networkRequest: Requestable
    private var baseUrl: String
    private var isGuestUser: Bool
    
    
    init(networkRequest: Requestable, baseUrl: String) {
        self.networkRequest = networkRequest
        self.baseUrl = baseUrl
        self.isGuestUser = AppCommonMethods.isGuestUser
        
    }
    
    
}
