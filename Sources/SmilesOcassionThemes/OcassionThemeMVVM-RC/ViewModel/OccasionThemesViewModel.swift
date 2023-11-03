
//  Created by Habib Rehman on 04/09/2023.
//

import Foundation
import Combine
import SmilesSharedServices
import SmilesUtilities
import SmilesOffers
import SmilesBanners
import SmilesLocationHandler
import SmilesStoriesManager
import NetworkingLayer


public class OccasionThemesViewModel: NSObject {
    
    // MARK: - PROPERTIES -
     var output: PassthroughSubject<Output, Never> = .init()
     var cancellables = Set<AnyCancellable>()
    
    // MARK: - VIEWMODELS -
    public let sectionsViewModel = SectionsViewModel()
    private let topBrandsViewModel = TopBrandsViewModel()
   // private let storiesViewModel = StoriesViewModel()
    
   // private let collectionsViewModel = CollectionsViewModel()
    
    private var sectionsUseCaseInput: PassthroughSubject<SectionsViewModel.Input, Never> = .init()
    private var topBrandsUseCaseInput: PassthroughSubject<TopBrandsViewModel.Input, Never> = .init()
    
    // MARK: - METHODS -
    public func logoutUser() {
       
    }
    
}

// MARK: - VIEWMODELS BINDINGS -
extension OccasionThemesViewModel {
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        output = PassthroughSubject<Output, Never>()
        input.sink { [weak self] event in
            switch event {
            case .getSections(let themeId):
                
                self?.bind(to: self?.sectionsViewModel ?? SectionsViewModel())
                self?.sectionsUseCaseInput.send(.getSections(baseUrl: AppCommonMethods.serviceBaseUrl, isGuestUser: AppCommonMethods.isGuestUser,themeId: themeId))
                
            case .getStories(let themeid, let tag, let pageNo):
//                SmilesStoriesHandler.shared.getStories(categoryId: themeid ?? 0, baseURL: AppCommonMethods.serviceBaseUrl, isGuestUser: AppCommonMethods.isGuestUser) { storiesResponse in
//                    self?.output.send(.fetchStoriesDidSucceed(response: storiesResponse))
//                } failure: { error in
//                    self?.output.send(.fetchSectionsDidFail(error: error))
//                }
                self?.getStories(categoryId: themeid ?? 0, tag: tag.rawValue,pageNo: pageNo ?? 0)
                
            case .getTopBrands(let categoryID, let menuItemType):
                self?.bind(to: self?.topBrandsViewModel ?? TopBrandsViewModel())
                self?.topBrandsUseCaseInput.send(.getTopBrands(categoryID: categoryID, menuItemType: menuItemType))
            case .getCollections(categoryID: let categoryID, menuItemType: let menuItemType):
                break
            case .getTopOffers(menuItemType: let menuItemType, bannerType: let bannerType, categoryId: let categoryId, bannerSubType: let bannerSubType):
                break
            }
            
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    func bind(to sectionsViewModel: SectionsViewModel) {
        sectionsUseCaseInput = PassthroughSubject<SectionsViewModel.Input, Never>()
        let output = sectionsViewModel.transform(input: sectionsUseCaseInput.eraseToAnyPublisher())
        output
            .sink { [weak self] event in
                switch event {
                case .fetchSectionsDidSucceed(let sectionsResponse):
                    debugPrint(sectionsResponse)
                    self?.output.send(.fetchSectionsDidSucceed(response: sectionsResponse))
                case .fetchSectionsDidFail(let error):
                    self?.output.send(.fetchSectionsDidFail(error: error))
                }
            }.store(in: &cancellables)
    }
    // TopBrands ViewModel Binding
    func bind(to topBrandsViewModel: TopBrandsViewModel) {
        topBrandsUseCaseInput = PassthroughSubject<TopBrandsViewModel.Input, Never>()
        let output = topBrandsViewModel.transform(input: topBrandsUseCaseInput.eraseToAnyPublisher())
        output
            .sink { [weak self] event in
                switch event {
                case .fetchTopBrandsDidSucceed(let topBrandsResponse):
                    print(topBrandsResponse)
                    self?.output.send(.fetchTopBrandsDidSucceed(response: topBrandsResponse))
                case .fetchTopBrandsDidFail(let error):
                    self?.output.send(.fetchTopBrandsDidFail(error: error))
                }
            }.store(in: &cancellables)
    }
}


extension OccasionThemesViewModel {
    
    func getStories(categoryId: Int, tag: String, pageNo: Int = 1) {
        let exclusiveOffersRequest = ExplorerGetExclusiveOfferRequest(categoryId: categoryId, tag: tag, pageNo: pageNo)
        
        let service = SmilesExplorerGetExclusiveOfferRepository(
            networkRequest: NetworkingLayerRequestable(requestTimeOut: 60), baseUrl: AppCommonMethods.serviceBaseUrl,
            endpoint: .getExclusiveOffer
        )
        
        service.getExclusiveOffers(request: exclusiveOffersRequest)
            .sink { [weak self] completion in
                debugPrint(completion)
                switch completion {
                case .failure(let error):
                    self?.output.send(.fetchStoriesDidFail(error: error))
                case .finished:
                    debugPrint("nothing much to do here")
                }
            } receiveValue: { [weak self] response in
                debugPrint("got my response here \(response)")
                
                self?.output.send(.fetchStoriesDidSucceed(response: response))
            }
        .store(in: &cancellables)
    }
}
