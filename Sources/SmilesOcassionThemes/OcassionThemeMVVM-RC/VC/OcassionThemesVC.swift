//
//  OcassionThemesVC.swift
//
//
//  Created by Habib Rehman on 30/10/2023.
//


import UIKit
import SmilesUtilities
import SmilesSharedServices
import Combine
import SmilesOffers
import SmilesLoader
import SmilesStoriesManager
import AnalyticsSmiles
import SmilesBanners

public class OcassionThemesVC: UIViewController {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var topBarHeight: NSLayoutConstraint!
    @IBOutlet weak var navTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - PROPERTIES -
    private var input: PassthroughSubject<OccasionThemesViewModel.Input, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    private lazy var viewModel: OccasionThemesViewModel = {
        return OccasionThemesViewModel()
    }()
    var topBrands: [GetTopBrandsResponseModel.BrandDO]?
    var dataSource: SectionedTableViewDataSource?
    var sections = [TableSectionData<OccasionThemesSectionIdentifier>]()
    //[OccasionThemesSectionData]()
    var occasionThemesSectionsData: GetSectionsResponseModel?
    private var themeId: Int = 1
    private var delegate:SmilesOccasionThemesHomeDelegate?
    var isHeaderExpanding = false
    var topBannerObject: TopPlaceholderThemeResponse?
    
    // MARK: - ACTIONS -
    @IBAction func backButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didPressedSearchbutton(sender: UIButton) {
        if let delegate = delegate {
            delegate.navigateToGlobalSearch()
        }
    }
    
    // MARK: - INITIALIZER -
    init(delegate: SmilesOccasionThemesHomeDelegate?, themeId: Int) {
        self.themeId = themeId
        self.delegate = delegate
        super.init(nibName: "OcassionThemesVC", bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        //self.themeId = 1 // need to commit this line after testing
        self.navTitle.fontTextStyle = .smilesHeadline3
        self.navBarView.isHidden = true
        setupTableView()
        bind(to: viewModel)
        getSections()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        self.topBarHeight.constant = 88
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Helping Functions
    
    func setupTableView() {
        self.tableView.sectionFooterHeight = .leastNormalMagnitude
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = CGFloat(0)
        }
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 1
        tableView.delegate = self
        tableView.contentInsetAdjustmentBehavior = .never
        let customizable: CellRegisterable? = OccasionThemesCellRegistration()
        customizable?.register(for: self.tableView)
        self.tableView.backgroundColor = .white
    }
    
    //MARK: Navigation Bar Setup
    fileprivate func configureDataSource() {
        self.tableView.dataSource = self.dataSource
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func getSectionIndex(for identifier: OccasionThemesSectionIdentifier) -> Int? {
        return sections.first(where: { obj in
            return obj.identifier == identifier
        })?.index
    }
    
    private func setupUI() {
        
        self.tableView.addMaskedCorner(withMaskedCorner: [.layerMinXMinYCorner, .layerMaxXMinYCorner], cornerRadius: 20.0)
        self.tableView.backgroundColor = .white
        self.sections.removeAll()
        
//        self.homeAPICalls()
    }
    
    func adjustTopHeader(_ scrollView: UIScrollView) {
        guard isHeaderExpanding == false else {return}
        if let tableView = scrollView as? UITableView {
            let items = (0..<tableView.numberOfSections).reduce(into: 0) { partialResult, sectionIndex in
                partialResult += tableView.numberOfRows(inSection: sectionIndex)
            }
            if items == 0 {
                return
            }
        }
        let isAlreadyCompact = !navBarView.isHidden
        let compact = scrollView.contentOffset.y > 20
        if compact != isAlreadyCompact {
            isHeaderExpanding = true
            self.navBarView.isHidden = !compact
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
                self.isHeaderExpanding = false
                //self.navBarView.isHidden = false
            }
        }
    }
   
}

// MARK: - SERVER CALLS -
extension OcassionThemesVC {
    
    private func getSections() {
        self.input.send(.getSections(themeId: self.themeId))
    }
    
    private func homeAPICalls() {
        
        if let sectionDetails = self.occasionThemesSectionsData?.sectionDetails, !sectionDetails.isEmpty {
            sections.removeAll()
            for (index, element) in sectionDetails.enumerated() {
                guard let sectionIdentifier = element.sectionIdentifier, !sectionIdentifier.isEmpty else {
                    return
                }
                
                if let section = OccasionThemesSectionIdentifier(rawValue: sectionIdentifier), section  != .topPlaceholder {
                    sections.append(TableSectionData(index: index, identifier: section))
                }
                switch OccasionThemesSectionIdentifier(rawValue: sectionIdentifier) {
                case .topPlaceholder:
                    self.input.send(.getThemesDetail(themeId: self.themeId))
                case .themeItemCategories:
                    
                    if let response = ItemCategoriesDetailsResponse.fromModuleFile() {
                        self.dataSource?.dataSources?[index] = TableViewDataSource.make(forItemCategories: response, data:"#FFFFFF", isDummy:true, onClick: nil)

                        
                    }
                    self.input.send(.getThemeCategories(themeId: self.themeId))
                    
                case .stories:
                    if let stories =  Stories.fromModuleFile() {
                        self.dataSource?.dataSources?[index] = TableViewDataSource.make(forStories: stories, data:"#FFFFFF", isDummy:true, onClick: nil)
                    }
                    self.input.send(.getStories(themeid: self.themeId, pageNo: 1))
                    
                case .topCollections:
                    if let response = GetCollectionsResponseModel.fromFile() {
                        self.dataSource?.dataSources?[index] = TableViewDataSource.make(forCollections: response, data:"#FFFFFF", isDummy: true, completion: nil)
                    }
                    self.input.send(.getCollections(themeId: self.themeId, menuItemType: nil))
                    
                case .topBrands:
                    if let response = GetTopBrandsResponseModel.fromFile() {
                        self.dataSource?.dataSources?[index] = TableViewDataSource.make(forBrands: response, data:"#FFFFFF", isDummy: true, topBrandsType: .foodOrder, completion: nil)
                    }
                    self.input.send(.getTopBrands(themeId: self.themeId, menuItemType: nil))
                    
                default: break
                }
            }
        }
        configureDataSource()
        
    }
    
    // MARK: - Section Data
    private func configureSectionsData(with sectionsResponse: GetSectionsResponseModel) {
        
        occasionThemesSectionsData = sectionsResponse
        if let sectionDetailsArray = sectionsResponse.sectionDetails, !sectionDetailsArray.isEmpty {
            self.dataSource = SectionedTableViewDataSource(dataSources: Array(repeating: [], count: sectionDetailsArray.count))
        }
        
        if (sectionsResponse.sectionDetails?.first(where: { $0.sectionIdentifier == OccasionThemesSectionIdentifier.topPlaceholder.rawValue })) != nil {
            self.configureDataSource()
        }
        homeAPICalls()
        
    }
    
}

// MARK: - VIEWMODEL CINDING -
extension OcassionThemesVC {
    
    func bind(to viewModel: OccasionThemesViewModel) {
        input = PassthroughSubject<OccasionThemesViewModel.Input, Never>()
        let output = viewModel.transform(input: input.eraseToAnyPublisher())
        output
            .sink { [weak self] event in
                switch event {
                case .fetchSectionsDidSucceed(let sectionsResponse):
                    self?.configureSectionsData(with: sectionsResponse)
                    
                case .fetchSectionsDidFail(error: let error):
                    debugPrint(error.localizedDescription)

                case .fetchStoriesDidSucceed(let stories):
                    self?.configureStoriesData(with: stories)
                    
                case .fetchStoriesDidFail(let error):
                    debugPrint(error.localizedDescription)
                    self?.configureHideSection(for: .stories, dataSource: Stories.self)
                    
                case .fetchTopBrandsDidSucceed(response: let response):
                    debugPrint(response)
                    self?.configureTopBrandsData(with: response)
                    
                case .fetchTopBrandsDidFail(error: _):
                    self?.configureHideSection(for: .topBrands, dataSource: GetTopBrandsResponseModel.self)
                    
                case .fetchCollectionsDidSucceed(response: let response):
                    self?.configureCollectionsData(with: response)
                    
                case .fetchCollectionDidFail(error: let error):
                    debugPrint(error.localizedDescription)
                    self?.configureHideSection(for: .topCollections, dataSource: GetCollectionsResponseModel.self)
                    
                case .fetchThemeCategoriesDidSucceed(response: let response):
                    debugPrint(response)
                    self?.configureItemCategoriesData(with: response)
                case .fetchThemeCategoriesDidFail(error: let error):
                    debugPrint(error.localizedDescription)
                    self?.configureHideSection(for: .themeItemCategories, dataSource: ItemCategoriesDetailsResponse.self)
                case.fetchThemeDetailDidSucceed(response: let response):
                    self?.topBannerObject = response
                    self?.configureDataSource()
                    
                case.fetchThemeDetailDidFail(error: let error):
                    debugPrint(error.localizedDescription)
                }
            }.store(in: &cancellables)
    }
    
}

// MARK: - SECTIONS CONFIGURATIONS -
extension OcassionThemesVC {
    
    // MARK: - configure for Theme Item Categories
    fileprivate func configureItemCategoriesData(with itemCategoriesResponse: ItemCategoriesDetailsResponse) {
        
        if let categories = itemCategoriesResponse.itemCategoriesDetails, !categories.isEmpty {
            if let storiesIndex = getSectionIndex(for: .themeItemCategories) {
                self.dataSource?.dataSources?[storiesIndex] = TableViewDataSource.make(forItemCategories: itemCategoriesResponse, data: self.occasionThemesSectionsData?.sectionDetails?[storiesIndex].backgroundColor ?? "#FFFFFF", onClick: { [weak self] category in
                    if let delegate = self?.delegate {
                        delegate.handleDeepLinkRedirection(redirectionUrl: category.redirectionUrl.asStringOrEmpty())
                    }
                })
                self.configureDataSource()
            } else {
                print("else case")
            }
        } else {
            print("Hide stories section is being called")
            self.configureHideSection(for: .stories, dataSource: Stories.self)
        }
        
    }
    
    // MARK: - configure for CollectionsData
    fileprivate func configureCollectionsData(with collectionsResponse: GetCollectionsResponseModel) {
        
        if let collections = collectionsResponse.collections, !collections.isEmpty {
            if let topCollectionsIndex = getSectionIndex(for: .topCollections) {
                self.dataSource?.dataSources?[topCollectionsIndex] = TableViewDataSource.make(forCollections: collectionsResponse, data: self.occasionThemesSectionsData?.sectionDetails?[topCollectionsIndex].backgroundColor ?? "#FFFFFF", completion: { [weak self] data in
                    
                    if let eventName = self?.occasionThemesSectionsData?.getEventName(for: OccasionThemesSectionIdentifier.topCollections.rawValue), !eventName.isEmpty {
                       // PersonalizationEventHandler.shared.registerPersonalizationEvent(eventName: eventName, urlScheme: data.redirectionUrl.asStringOrEmpty(), offerId: data.id, source: self?.personalizationEventSource)
                    }
                    if let delegate = self?.delegate {
                        delegate.handleDeepLinkRedirection(redirectionUrl: data.redirectionUrl.asStringOrEmpty())
                    }
                })
                self.configureDataSource()
            }
        } else {
            self.configureHideSection(for: .topCollections, dataSource: GetCollectionsResponseModel.self)
        }
        
    }
    
    fileprivate func configureStoriesData(with storiesResponse: Stories) {
        
        if let stories = storiesResponse.stories, !stories.isEmpty {
            if let storiesIndex = getSectionIndex(for: .stories) {
                self.dataSource?.dataSources?[storiesIndex] = TableViewDataSource.make(forStories: storiesResponse, data: self.occasionThemesSectionsData?.sectionDetails?[storiesIndex].backgroundColor ?? "#FFFFFF", onClick: { [weak self] story in
                    
                    if var stories = ((self?.dataSource?.dataSources?[safe: storiesIndex] as? TableViewDataSource<Stories>)?.models)?.first {
//                        let analyticsSmiles = AnalyticsSmiles(service: FirebaseAnalyticsService())
//                        analyticsSmiles.sendAnalyticTracker(trackerData: Tracker(eventType: AnalyticsEvent.firebaseEvent(.ClickOnStory).name, parameters: [:]))
//                        
//                        if let eventName = self?.foodSections?.getEventName(for: SectionIdentifier.STORIES.rawValue), !eventName.isEmpty {
//                            PersonalizationEventHandler.shared.registerPersonalizationEvent(eventName: eventName, offerId: story.storyID ?? "", source: self?.personalizationEventSource)
//                        }
                        self?.openStories(stories: stories.stories ?? [], storyIndex: stories.stories?.firstIndex(of: story) ?? 0){storyIndex,snapIndex,isFavorite in
                            stories.setFavourite(isFavorite: isFavorite, storyIndex: storyIndex, snapIndex: snapIndex)
                            (self?.dataSource?.dataSources?[safe: storiesIndex] as? TableViewDataSource<Stories>)?.models = [stories]
                        }
                    }
                })
                self.configureDataSource()
            } else {
                print("else case")
            }
        } else {
            print("Hide stories section is being called")
            self.configureHideSection(for: .stories, dataSource: Stories.self)
        }
        
    }
    func openStories(stories: [Story], storyIndex:Int, favouriteUpdatedCallback: ((_ storyIndex:Int,_ snapIndex:Int,_ isFavourite:Bool) -> Void)? = nil) {
        if let delegate = self.delegate {
            delegate.navigateToStoriesDetailVC(stories: stories, storyIndex: storyIndex, favouriteUpdatedCallback: favouriteUpdatedCallback)
        }
        
    }
    fileprivate func configureTopBrandsData(with topBrandsResponse: GetTopBrandsResponseModel) {
        
        self.topBrands = topBrandsResponse.brands
        if let brands = topBrandsResponse.brands, !brands.isEmpty {
            if let topBrandsIndex = getSectionIndex(for: .topBrands) {
                self.dataSource?.dataSources?[topBrandsIndex] = TableViewDataSource.make(forBrands: topBrandsResponse, data: self.occasionThemesSectionsData?.sectionDetails?[topBrandsIndex].backgroundColor ?? "#FFFFFF", topBrandsType: .foodOrder, completion: { [weak self] data in
                    if let delegate = self?.delegate {
                        delegate.handleDeepLinkRedirection(redirectionUrl: data.redirectionUrl.asStringOrEmpty())
                    }
                })
                self.configureDataSource()
            }
        } else {
            print("Hide top brand is being called")
            self.configureHideSection(for: .topBrands, dataSource: GetTopBrandsResponseModel.self)
        }
        
    }
    
    fileprivate func configureHideSection<T>(for section: OccasionThemesSectionIdentifier, dataSource: T.Type) {
        
        if let index = getSectionIndex(for: section) {
            (self.dataSource?.dataSources?[index] as? TableViewDataSource<T>)?.models = []
            (self.dataSource?.dataSources?[index] as? TableViewDataSource<T>)?.isDummy = false
            self.configureDataSource()
        }
        
    }
}

