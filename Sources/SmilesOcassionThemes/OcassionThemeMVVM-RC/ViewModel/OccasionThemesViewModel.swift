
//  Created by Habib Rehman on 04/09/2023.
//

import Foundation
import Combine
import SmilesSharedServices
import SmilesUtilities
import SmilesOffers
import SmilesBanners
import SmilesStoriesManager
import NetworkingLayer


class OccasionThemesViewModel: NSObject {
    
    // MARK: - PROPERTIES -
    var output: PassthroughSubject<Output, Never> = .init()
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - VIEWMODELS -
    private let sectionsViewModel = SectionsViewModel()
    private let topBrandsViewModel = TopBrandsViewModel()
    private let collectionsViewModel = CollectionsViewModel()
    
    private var sectionsUseCaseInput: PassthroughSubject<SectionsViewModel.Input, Never> = .init()
    private var topBrandsUseCaseInput: PassthroughSubject<TopBrandsViewModel.Input, Never> = .init()
    private var collectionsUseCaseInput: PassthroughSubject<CollectionsViewModel.Input, Never> = .init()
    
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
                
            case .getStories(let themeid, _):
                SmilesStoriesHandler.shared.getStories(themeid: themeid , baseURL: AppCommonMethods.serviceBaseUrl, isGuestUser: AppCommonMethods.isGuestUser) { storiesResponse in
                    self?.output.send(.fetchStoriesDidSucceed(response: storiesResponse))
                } failure: { error in
                    self?.output.send(.fetchSectionsDidFail(error: error))
                }
            case .getCollections(themeId: let themeId, menuItemType: let menuItemType):
                self?.bind(to: self?.collectionsViewModel ?? CollectionsViewModel())
                self?.collectionsUseCaseInput.send(.getCollections(categoryID: nil, menuItemType: menuItemType, themeId: String(themeId ?? 0)))
                
            case .getTopBrands(let themeid, let menuItemType):
                self?.bind(to: self?.topBrandsViewModel ?? TopBrandsViewModel())
                self?.topBrandsUseCaseInput.send(.getTopBrands(categoryID: nil, menuItemType: menuItemType, themeId: String(themeid ?? 0)))
                
            case .getThemeCategories(themeId: let themeId):
                self?.getThemeCategories(for: themeId)
                
            case .getThemesDetail(themeId: let themeId):
                self?.getThemeDetail(for: themeId)
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
    
    // MARK: -  TopBrands ViewModel Binding
    
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
    
    // MARK: -  Collections ViewModel Binding
    
    func bind(to collectionsViewModel: CollectionsViewModel) {
        collectionsUseCaseInput = PassthroughSubject<CollectionsViewModel.Input, Never>()
        let output = collectionsViewModel.transform(input: collectionsUseCaseInput.eraseToAnyPublisher())
        output
            .sink { [weak self] event in
                switch event {
                case .fetchCollectionsDidSucceed(let collectionResponse):
                    debugPrint(collectionResponse)
                    self?.output.send(.fetchCollectionsDidSucceed(response: collectionResponse))
                case .fetchCollectionsDidFail(let error):
                    self?.output.send(.fetchCollectionDidFail(error: error))
                }
            }.store(in: &cancellables)
    }
    
    
    
}



extension OccasionThemesViewModel {
    
    private func getThemeCategories(for themeId: Int? = nil) {
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
    
    private func getThemeDetail(for themeId: Int? = nil) {
        let getThemeDetailsRequest = TopPlaceholderThemeRequest(
            themeId: themeId
        )
        
        let service = OcassionThemesRepository(
            networkRequest: NetworkingLayerRequestable(requestTimeOut: 60),
            baseUrl: AppCommonMethods.serviceBaseUrl
        )
        
        service.getThemeDetailService(request: getThemeDetailsRequest)
            .sink { [weak self] completion in
                debugPrint(completion)
                switch completion {
                case .failure(let error):
                    self?.output.send(.fetchThemeDetailDidFail(error: error))
                case .finished:
                    debugPrint("nothing much to do here")
                }
            } receiveValue: { [weak self] response in
                debugPrint("got my response here \(response)")
                self?.output.send(.fetchThemeDetailDidSucceed(response: response))
                
            }
            .store(in: &cancellables)
    }
}
