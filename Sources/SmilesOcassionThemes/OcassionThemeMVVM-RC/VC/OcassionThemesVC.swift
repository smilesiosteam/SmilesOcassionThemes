//
//  OcassionThemesVC.swift
//
//
//  Created by Habib Rehman on 30/10/2023.
//


import UIKit
import SmilesUtilities
import SmilesSharedServices
import AppHeader
import SmilesLocationHandler
import Combine
import SmilesOffers
import SmilesLoader
import SmilesStoriesManager
import AnalyticsSmiles
import SmilesBanners
import SmilesPersonalizationEvent



public class OcassionThemesVC: UIViewController {
    
    @IBOutlet weak var topHeaderView: AppHeaderView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    public  var input: PassthroughSubject<OccasionThemesViewModel.Input, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    private lazy var viewModel: OccasionThemesViewModel = {
        return OccasionThemesViewModel()
    }()
    
    var dataSource: SectionedTableViewDataSource?
    var sections =  [TableSectionData<OccasionThemesSectionIdentifier>]()
    //[OccasionThemesSectionData]()
    var occasionThemesSectionsData: GetSectionsResponseModel?
    let themeid: Int = 1
    private let isGuestUser: Bool = false
    private var isUserSubscribed: Bool? = false
    var subscriptionType: ExplorerPackage?
    private var voucherCode: String?
    public var delegate:SmilesOccasionThemesHomeDelegate?
    private var selectedIndexPath: IndexPath?
    var mutatingSectionDetails = [SectionDetailDO]()
    private var offerFavoriteOperation = 0
    
    var selectedLocation: String? = nil
    var isHeaderExpanding = false
    var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    
    
    //var categoryId = 0
    public   var offersCategoryId = 0
    
    
   public var selectedSortTypeIndex: Int?
   public var didSelectFilterOrSort = false
    
    var offersListing: OcassionThemesOfferResponse?
    var bogooffersListing: OffersCategoryResponseModel?
    var offersPage = 1 // For offers list pagination
    var dodOffersPage = 1 // For DOD offers list pagination
    var offers = [ExplorerOffer]()
    var bogoOffers = [OfferDO]()
    
    public var filtersSavedList: [RestaurantRequestWithNameFilter]?
    public var filtersData: [FiltersCollectionViewCellRevampModel]?
    public var savedFilters: [RestaurantRequestFilter]?
    public var restaurantSortingResponseModel: GetSortingListResponseModel?
    public var selectedSortingTableViewCellModel: FilterDO?
    private var onFilterClick:(() -> Void)?
    public var filtersList: [RestaurantRequestFilter]?
    public var selectedSort: String?
    private var rewardPoint: Int?
    private var rewardPointIcon: String?
    private var personalizationEventSource: String?
    private var platinumLimiReached: Bool?
    var restaurants = [Restaurant]()

    
    public init(delegate: SmilesOccasionThemesHomeDelegate?) {
        self.delegate = delegate
        super.init(nibName: "OcassionThemesVC", bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        
        setupTableView()
        bind(to: viewModel)
        getSections()
        
//        selectedLocation = LocationStateSaver.getLocationInfo()?.locationId
       
        self.setupHeaderView(headerTitle: "")
        
        let imageName = AppCommonMethods.languageIsArabic() ? "back_arrow_ar" : "back_arrow"
        self.topHeaderView.setCustomImageForBackButton(imageName: imageName)
    }
    
    
    public override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
        if let currentLocationId = LocationStateSaver.getLocationInfo()?.locationId, let locationId = self.selectedLocation, currentLocationId != locationId {
//            self.input.send(.emptyRestaurantList)
//            self.callFoodOrderServices()
            selectedLocation = LocationStateSaver.getLocationInfo()?.locationId
        }
        
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
        
        let customizable: CellRegisterable? = OccasionThemesCellRegistration()
        customizable?.register(for: self.tableView)
        self.tableView.backgroundColor = .white
        // ----- Tableview section header hide in case of tableview mode Plain ---
        let dummyViewHeight = CGFloat(150)
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: dummyViewHeight))
        self.tableView.contentInset = UIEdgeInsets(top: -dummyViewHeight, left: 0, bottom: 0, right: 0)
        
        // ----- Tableview section header hide in case of tableview mode Plain ---
    }
    
    //MARK: Navigation Bar Setup
    func setUpNavigationBar() {
        
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.configureWithTransparentBackground()
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        
        let imageView = UIImageView()
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24)
        ])
        imageView.tintColor = .black
        var toptitle: String = "Smiles Tourist"
        if let topPlaceholderSection = self.occasionThemesSectionsData?.sectionDetails?.first(where: { $0.sectionIdentifier == OccasionThemesSectionIdentifier.topPlaceholder.rawValue }) {
            imageView.sd_setImage(with: URL(string: topPlaceholderSection.iconUrl ?? "")) { image, _, _, _ in
                imageView.image = image?.withRenderingMode(.alwaysTemplate)
                toptitle = topPlaceholderSection.title ?? toptitle
            }
        }
        
        let locationNavBarTitle = UILabel()
        locationNavBarTitle.text = toptitle
        locationNavBarTitle.textColor = .black
        locationNavBarTitle.fontTextStyle = .smilesHeadline4
        let hStack = UIStackView(arrangedSubviews: [imageView, locationNavBarTitle])
        hStack.spacing = 4
        hStack.alignment = .center
        self.navigationItem.titleView = hStack
        
        let btnBack: UIButton = UIButton(type: .custom)
        btnBack.backgroundColor = UIColor.clear
        btnBack.setImage(UIImage(named: AppCommonMethods.languageIsArabic() ? "back_arrow_ar" : "back_arrow", in: .module, compatibleWith: nil), for: .normal)
        btnBack.addTarget(self, action: #selector(self.onClickBack), for: .touchUpInside)
        btnBack.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        btnBack.layer.cornerRadius = btnBack.frame.height / 2
        btnBack.clipsToBounds = true
        let barButton = UIBarButtonItem(customView: btnBack)
        self.navigationItem.leftBarButtonItem = barButton
        self.topHeaderView.isHidden = true
        if hasTopNotch {
            self.tableViewTopConstraint.constant = ((-212) + ((self.navigationController?.navigationBar.frame.height ?? 0.0)))
        } else{
            self.tableViewTopConstraint.constant = ((-212) + ((self.navigationController?.navigationBar.frame.height ?? 0.0)-30.0))
        }
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
    @objc func onClickBack() {
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onUpgradeBannerButtonClick() {
       
    }
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
    // MARK: - Top Header
    private func setupHeaderView(headerTitle: String?) {
        topHeaderView.delegate = self
        topHeaderView.setupHeaderView(backgroundColor: .white, searchBarColor: .white, pointsViewColor: .black.withAlphaComponent(0.1), titleColor: .black, headerTitle: headerTitle.asStringOrEmpty(), showHeaderNavigaton: true, haveSearchBorder: true, shouldShowBag: false, isGuestUser: isGuestUser, showHeaderContent: isUserSubscribed ?? false, toolTipInfo: nil)
        displayRewardPoints()
    }
    func displayRewardPoints() {
        if let rewardPoints = rewardPoint {
            self.topHeaderView.setPointsOfUser(with: rewardPoints.numberWithCommas())
        }
        
        if let rewardPointsIcon = self.rewardPointIcon {
        self.topHeaderView.setPointsIcon(with: rewardPointsIcon, shouldShowAnimation: false)
        }
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
        let isAlreadyCompact = !topHeaderView.bodyViewCompact.isHidden
        let compact = scrollView.contentOffset.y > 150
        if compact != isAlreadyCompact {
            isHeaderExpanding = true
            topHeaderView.adjustUI(compact: compact,isBackgroundColorClear: true)
            topHeaderView.view_container.backgroundColor = .white
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
                self.isHeaderExpanding = false
            }
        }
    }
    private func updateView(index: Int) {


        //self?.adjustTopHeader(scrollView)

    }
}


// MARK: - APP HEADER DELEGATE -
extension OcassionThemesVC: AppHeaderDelegate {
    
    public func didTapOnBackButton() {

        navigationController?.popViewController()
        
    }
    
    public func didTapOnSearch() {
        self.delegate?.navigateToGlobalSearch()
       // self.categoryContainerCoordinator?.navigateToGlobalSearchVC()
    }
    
    public func didTapOnLocation() {
        self.delegate?.navigateToLocation()
        //self.categoryContainerCoordinator?.navigateToUpdateLocationVC(confirmLocationRedirection: .toCategoryContainer)
    }
    
    func setLocationToolTipPositionView(view: UIImageView) {
//        self.locationToolTipPosition = view
    }
    
    public func segmentLeftBtnTapped(index: Int) {
        updateView(index: index)
    }
    
    public func segmentRightBtnTapped(index: Int) {
        updateView(index: index)
    }
    
    @IBAction func upgradeTapped(_ sender: Any){
       
    }
    
    public func rewardPointsBtnTapped() {
        self.delegate?.navigateToRewardPoint(personalizationEventSource: self.personalizationEventSource)
       // self.categoryContainerCoordinator?.navigateToTransactionsListViewController(personalizationEventSource: self.personalizationEventSource)
    }
}

extension OcassionThemesVC {
    // MARK: - Get Sections Api Calls
    private func getSections() {
        self.input.send(.getSections(themeId: self.themeid))
    }
    
    
    // MARK: - HomeApi Calls
    
    private func homeAPICalls() {
        
        if let sectionDetails = self.occasionThemesSectionsData?.sectionDetails, !sectionDetails.isEmpty {
            sections.removeAll()
            for (index, element) in sectionDetails.enumerated() {
                guard let sectionIdentifier = element.sectionIdentifier, !sectionIdentifier.isEmpty else {
                    return
                }
//                if let section = OccasionThemesSectionIdentifier(rawValue: sectionIdentifier), section != .topPlaceholder {
//                                    sections.append(TableSectionData(index: index, identifier: section))
//                }
                
                switch OccasionThemesSectionIdentifier(rawValue: sectionIdentifier) {
                    
                case .topPlaceholder:
                    if let bannerIndex = getSectionIndex(for: .topPlaceholder) {
                        guard let bannerSectionData = self.occasionThemesSectionsData?.sectionDetails?[bannerIndex] else {return}
                        self.configureUpgardeBanner(with: bannerSectionData, index: bannerIndex)
                    }
                case .themeItemCategories:
                    
                    if let response = OfferDO.fromModuleFile() {
                        self.dataSource?.dataSources?[index] = TableViewDataSource.make(forBogoOffers: [response], data:"#FFFFFF", isDummy: true, completion:nil)
                    }
                    //self.input.send(.getBogoOffers(categoryId: self.categoryId, tag: .exclusiveDealsBogoOffers, pageNo: 1))
                    break
                case .stories:
                    
                    if let response = OcassionThemesOfferResponse.fromModuleFile() {
                        self.dataSource?.dataSources?[index] = TableViewDataSource.make(forStories: response, data:"#FFFFFF", isDummy: true, onClick:nil)
                    }
                    
                    self.input.send(.getStories(themeid: self.themeid, tag: .exclusiveDealsStories, pageNo: 1))
                    
                    break
                case .topCollections:
                    
                    if let response = OcassionThemesOfferResponse.fromModuleFile() {
                        self.dataSource?.dataSources?[index] = TableViewDataSource.make(forStories: response, data:"#FFFFFF", isDummy: true, onClick:nil)
                    }
                    
                    //self.input.send(.getExclusiveDealsStories(categoryId: self.categoryId, tag: .exclusiveDealsStories, pageNo: 1))
                    
                    break
                case .topBrands:
                    
                    if let response = GetTopBrandsResponseModel.fromFile() {
                        self.dataSource?.dataSources?[index] = TableViewDataSource.make(forBrands: response, data:"#FFFFFF", isDummy: true, topBrandsType: .foodOrder, completion: nil)
                    }
                    self.input.send(.getTopBrands(themeId: self.themeid, menuItemType: nil))
                    
                default: break
                }
            }
        }
        self.tableView.reloadData()
    }
    
    
    // MARK: - Section Data
    private func configureSectionsData(with sectionsResponse: GetSectionsResponseModel) {
        
        occasionThemesSectionsData = sectionsResponse
        if let sectionDetailsArray = sectionsResponse.sectionDetails, !sectionDetailsArray.isEmpty {
            print(sectionDetailsArray.count)
            self.dataSource = SectionedTableViewDataSource(dataSources: Array(repeating: [], count: sectionDetailsArray.count))
            print(self.dataSource?.dataSources?.count)
        }
        
        
        
        if let topPlaceholderSection = sectionsResponse.sectionDetails?.first(where: { $0.sectionIdentifier == OccasionThemesSectionIdentifier.topPlaceholder.rawValue }) {
            
                setupHeaderView(headerTitle: topPlaceholderSection.title)
                
                if let iconURL = topPlaceholderSection.iconUrl {
                    self.topHeaderView.headerTitleImageView.isHidden = false
                    self.topHeaderView.setHeaderTitleIcon(iconURL: iconURL)
                }
                let imageName = AppCommonMethods.languageIsArabic() ? "back_arrow_ar" : "back_arrow"
                self.topHeaderView.setCustomImageForBackButton(imageName: imageName)
            
            self.configureDataSource()
            homeAPICalls()
            
        }
        
    }
    
}


extension OcassionThemesVC {
    
    
    // MARK: - Section Data
    
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
                    
                case .fetchStoriesDidSucceed(let exclusiveOffersStories):
                    self?.configureExclusiveOffersStories(with: exclusiveOffersStories)
                    
                case .fetchStoriesDidFail(let error):
                    debugPrint(error.localizedDescription)
                   // self?.configureHideSection(for: .stories, dataSource: OcassionThemesOfferResponse.self)
                case .fetchTopBrandsDidSucceed(response: let response):
                    debugPrint(response)
                    self?.configureTopBrandsData(with: response)
                case .fetchTopBrandsDidFail(error: let error):
                    debugPrint(error.localizedDescription)
                case .fetchTopOffersDidSucceed(response: let response):
                    debugPrint(response)
                case .fetchTopOffersDidFail(error: let error):
                    debugPrint(error.localizedDescription)
                   // self?.configureHideSection(for: .stories, dataSource: OcassionThemesOfferResponse.self)

                case .fetchCollectionsDidSucceed(response: let response):
                    self?.configureCollectionsData(with: response)
                case .fetchCollectionDidFail(error: let error):
                    debugPrint(error.localizedDescription)
                    self?.configureHideSection(for: .topCollections, dataSource: GetCollectionsResponseModel.self)
                }
            }.store(in: &cancellables)
    }
    
}
extension OcassionThemesVC {
    // MARK: - SECTIONS CONFIGURATIONS -
    
    
    private func configureHeaderSection() {
        
        if let headerSectionIndex = getSectionIndex(for: .stories) {
            dataSource?.dataSources?[headerSectionIndex] = TableViewDataSource(models: [], reuseIdentifier: "", data: "#FFFFFF", cellConfigurator: { _, _, _, _ in })
            configureDataSource()
        }
        
        
    }
    fileprivate func configureCollectionsData(with collectionsResponse: GetCollectionsResponseModel) {
        if let collections = collectionsResponse.collections, !collections.isEmpty {
            if let topCollectionsIndex = getSectionIndex(for: .topCollections) {
                self.dataSource?.dataSources?[topCollectionsIndex] = TableViewDataSource.make(forCollections: collectionsResponse, data: self.occasionThemesSectionsData?.sectionDetails?[topCollectionsIndex].backgroundColor ?? "#FFFFFF", completion: { [weak self] data in
                    
                    if let eventName = self?.occasionThemesSectionsData?.getEventName(for: OccasionThemesSectionIdentifier.topCollections.rawValue), !eventName.isEmpty {
                        PersonalizationEventHandler.shared.registerPersonalizationEvent(eventName: eventName, urlScheme: data.redirectionUrl.asStringOrEmpty(), offerId: data.id, source: self?.personalizationEventSource)
                    }
                   // self?.handleBannerDeepLinkRedirections(url: data.redirectionUrl.asStringOrEmpty())
                })
                self.configureDataSource()
            }
        } else {
            self.configureHideSection(for: .topCollections, dataSource: GetCollectionsResponseModel.self)
        }
    }
    fileprivate func  configureExclusiveOffersStories(with exclusiveOffersResponse: OcassionThemesOfferResponse) {
        
        self.offersListing = exclusiveOffersResponse
        self.offers.append(contentsOf: exclusiveOffersResponse.offers ?? [])
        if  !self.offers.isEmpty {
            if let storiesIndex = getSectionIndex(for: .stories) {
                self.dataSource?.dataSources?[storiesIndex] = TableViewDataSource.make(forStories: exclusiveOffersResponse, data: self.occasionThemesSectionsData?.sectionDetails?[storiesIndex].backgroundColor ?? "#FFFFFF", onClick: { [weak self] story in
                   // self?.delegate?.navigateToStoriesWebView(objStory: story)
                })
                self.configureDataSource()
            }
        } else {
            if self.offers.isEmpty {
               // self.configureHideSection(for: .stories, dataSource: OcassionThemesOfferResponse.self)
            }
        }
        
    
    }
    fileprivate func configureTopBrandsData(with topBrandsResponse: GetTopBrandsResponseModel) {
        if let brands = topBrandsResponse.brands, !brands.isEmpty {
            if let topBrandsIndex = getSectionIndex(for: .topBrands) {
                self.dataSource?.dataSources?[topBrandsIndex] = TableViewDataSource.make(forBrands: topBrandsResponse, data: self.occasionThemesSectionsData?.sectionDetails?[topBrandsIndex].backgroundColor ?? "#FFFFFF", topBrandsType: .foodOrder, completion: { [weak self] data in
//                    let analyticsSmiles = AnalyticsSmiles(service: FirebaseAnalyticsService())
//                    analyticsSmiles.sendAnalyticTracker(trackerData: Tracker(eventType: AnalyticsEvent.firebaseEvent(.ClickOnTopBrands).name, parameters: [:]))
//                    
//                    if let eventName = self?.categoryDetailsSections?.getEventName(for: SectionIdentifier.TOPBRANDS.rawValue), !eventName.isEmpty {
//                        PersonalizationEventHandler.shared.registerPersonalizationEvent(eventName: eventName, urlScheme: data.redirectionUrl.asStringOrEmpty(), offerId: data.id, source: self?.personalizationEventSource)
//                    }
                   // self?.handleBannerDeepLinkRedirections(url: data.redirectionUrl.asStringOrEmpty())
                })
                self.configureDataSource()
            }
        } else {
           // self.configureHideSection(for: .topBrands, dataSource: GetTopBrandsResponseModel.self)
        }
    }
    
    fileprivate func  configureUpgardeBanner(with sectionsResponse: SectionDetailDO?,index: Int) {
        
        if let bannerSectionResponse = sectionsResponse, (bannerSectionResponse.backgroundImage != nil) {
            
            self.dataSource?.dataSources?[index] = TableViewDataSource.make(forUpgradeBanner: bannerSectionResponse, data: "", onClick: { sections in
                print(sections)
            })
            self.configureDataSource()
            
        } else {
          //  self.configureHideSection(for: .topPlaceholder, dataSource: SectionDetailDO.self)
        }
        
        
        
    }
    
    
    fileprivate func configureExclusiveOffers(with exclusiveOffersResponse: OcassionThemesOfferResponse) {
        self.offersListing = exclusiveOffersResponse
        self.offers.append(contentsOf: exclusiveOffersResponse.offers ?? [])
        if !offers.isEmpty {
            if let offersCategoryIndex = getSectionIndex(for: .stories) {

                self.dataSource?.dataSources?[offersCategoryIndex] = TableViewDataSource.make(forOffers: self.offersListing ?? OcassionThemesOfferResponse(), data: self.occasionThemesSectionsData?.sectionDetails?[offersCategoryIndex].backgroundColor ?? "#FFFFFF", completion: { [weak self] explorerOffer in

                    print(explorerOffer)
                    
                })
                self.configureDataSource()
            }
        } else {
            if self.offers.isEmpty {
                self.configureHideSection(for: .topCollections, dataSource: OcassionThemesOfferResponse.self)
            }
        }
    }
    
    fileprivate func configureBogoOffers(with exclusiveOffersResponse: OffersCategoryResponseModel) {
        self.bogooffersListing = exclusiveOffersResponse
        self.bogoOffers.append(contentsOf: exclusiveOffersResponse.offers ?? [])
        if !bogoOffers.isEmpty {
            if let offersIndex = getSectionIndex(for: .topCollections) {
                self.dataSource?.dataSources?[offersIndex] = TableViewDataSource.make(forBogoOffers: self.bogoOffers , data: self.occasionThemesSectionsData?.sectionDetails?[offersIndex].backgroundColor ?? "#FFFFFF", completion: { [weak self] isFavorite, offerId, indexPath  in
                    self?.selectedIndexPath = indexPath
                   // self?.updateOfferWishlistStatus(isFavorite: isFavorite, offerId: offerId)
                })
                self.configureDataSource()
            }
        } else {
            if self.bogoOffers.isEmpty {
                self.configureHideSection(for: .topCollections, dataSource: OfferDO.self)
            }
        }
    }
    
    fileprivate func configureWishListData(with updateWishlistResponse: WishListResponseModel) {
        var isFavoriteOffer = false
        
        if let favoriteIndexPath = self.selectedIndexPath {
            if let updateWishlistStatus = updateWishlistResponse.updateWishlistStatus, updateWishlistStatus {
                isFavoriteOffer = self.offerFavoriteOperation == 1 ? true : false
            } else {
                isFavoriteOffer = false
            }
            
            (self.dataSource?.dataSources?[favoriteIndexPath.section] as? TableViewDataSource<OfferDO>)?.models?[favoriteIndexPath.row].isWishlisted = isFavoriteOffer
            
            if let cell = tableView.cellForRow(at: favoriteIndexPath) as? RestaurantsRevampTableViewCell {
                cell.offerData?.isWishlisted = isFavoriteOffer
                cell.showFavouriteAnimation(isRestaurant: false)
            }
            
        }
    }
    
    fileprivate func configureHideSection<T>(for section: OccasionThemesSectionIdentifier, dataSource: T.Type) {
        if let index = getSectionIndex(for: section) {
            (self.dataSource?.dataSources?[index] as? TableViewDataSource<T>)?.models = []
            (self.dataSource?.dataSources?[index] as? TableViewDataSource<T>)?.isDummy = false
            self.mutatingSectionDetails.removeAll(where: { $0.sectionIdentifier == section.rawValue })
            
            self.configureDataSource()
        }
    }
}

extension OcassionThemesVC {
    
    func redirectToFilters() {
        
      
        
    }
    
    func redirectToSortingVC(){
        
        
    }
    
    
}


