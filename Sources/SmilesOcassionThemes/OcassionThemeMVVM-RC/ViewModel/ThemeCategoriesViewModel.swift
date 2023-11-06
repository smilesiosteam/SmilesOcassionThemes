//
//  File.swift
//  
//
//  Created by Habib Rehman on 06/11/2023.
//

import Foundation
//
//  TopBrandsViewModel.swift
//  House
//
//  Created by Hanan Ahmed on 10/31/22.
//  Copyright © 2022 Ahmed samir ali. All rights reserved.
//

import Foundation
import Combine
import NetworkingLayer
import SmilesUtilities


//ThemeCategoriesRequest//
public class ThemeCategoriesViewModel: NSObject {
    
    // MARK: - INPUT. View event methods
    public enum Input {
        case getThemeCategories(themeId: Int? = nil)
    }
    
    public enum Output {
        case fetchThemeCategoriesDidSucceed(response: ThemeCategoriesResponse)
        case fetchThemeCategoriesDidFail(error: Error)
    }
    
    // MARK: -- Variables
    private var output: PassthroughSubject<Output, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
}

// MARK: - INPUT. View event methods
extension ThemeCategoriesViewModel {
    public func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        output = PassthroughSubject<Output, Never>()
        input.sink { [weak self] event in
            switch event {
            case .getThemeCategories(let themeId):
                self?.getThemeCategories(for: themeId)
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    // Get All Top Brands
    public func getThemeCategories(for themeId: Int? = nil) {
        let getThemeCategoriesRequest = ThemeCategoriesRequest(
            themeId: themeId
        )
        
        let service = OcassionThemesRepository(
            networkRequest: NetworkingLayerRequestable(requestTimeOut: 60),
            baseUrl: AppCommonMethods.serviceBaseUrl
        )
        
        service.getThemeCategoriesService(request: getThemeCategoriesRequest)
            .sink { [weak self] completion in
                debugPrint(completion)
                switch completion {
                case .failure(let error):
                    self?.output.send(.fetchThemeCategoriesDidFail(error: error))
                case .finished:
                    debugPrint("nothing much to do here")
                }
            } receiveValue: { [weak self] response in
                debugPrint("got my response here \(response)")
                self?.output.send(.fetchThemeCategoriesDidSucceed(response: response))
            }
        .store(in: &cancellables)
    }
}
