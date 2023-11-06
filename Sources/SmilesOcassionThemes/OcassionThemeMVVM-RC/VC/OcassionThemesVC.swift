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
    public var themeid: Int = 1
    private let isGuestUser: Bool = false
    public var delegate:SmilesOccasionThemesHomeDelegate?
   
    var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    
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
    }
    
    
    public override func viewWillAppear(_ animated: Bool) {
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
        
        let customizable: CellRegisterable? = OccasionThemesCellRegistration()
        customizable?.register(for: self.tableView)
        self.tableView.backgroundColor = .white
        // ----- Tableview section header hide in case of tableview mode Plain ---
        let dummyViewHeight = CGFloat(150)
    
//        self.tableView.tableHeaderView = OcassionThemeHeaderView()
//        self.tableView.tableHeaderView?.backgroundColor = .lightGray
        
//        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: dummyViewHeight))
//        self.tableView.contentInset = UIEdgeInsets(top: -dummyViewHeight, left: 0, bottom: 0, right: 0)

        
        
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
                      //  self.configureUpgardeBanner(with: bannerSectionData, index: bannerIndex)
                    }
                case .themeItemCategories:
                    
                    if let response = ThemeCategoriesResponse.fromModuleFile() {
                        self.dataSource?.dataSources?[index] = TableViewDataSource.make(forItemCategories: [response], data:"#FFFFFF", isDummy:true, onClick: nil)
                        
                    }
                    self.input.send(.getThemeCategories(themeId: 125))
                    break
                case .stories:
                    
                    if let stories =  Stories.fromModuleFile() {
                        self.dataSource?.dataSources?[index] = TableViewDataSource.make(forStories: stories, data:"#FFFFFF", isDummy:true, onClick: nil)
                    }
                    
                    self.input.send(.getStories(themeid: self.themeid, pageNo: 1))
                    
                    break
                case .topCollections:
                    
                    if let response = GetCollectionsResponseModel.fromFile() {
                        self.dataSource?.dataSources?[index] = TableViewDataSource.make(forCollections: response, data:"#FFFFFF", isDummy: true, completion: nil)
                    }
                    self.input.send(.getCollections(themeId: self.themeid, menuItemType: nil))
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
            self.dataSource = SectionedTableViewDataSource(dataSources: Array(repeating: [], count: sectionDetailsArray.count))
        }
        
        if let topPlaceholderSection = sectionsResponse.sectionDetails?.first(where: { $0.sectionIdentifier == OccasionThemesSectionIdentifier.topPlaceholder.rawValue }) {
            self.configureDataSource()
        }
        homeAPICalls()
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
                case .fetchThemeCategoriesDidFail(error: let error):
                    debugPrint(error.localizedDescription)
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
                       // PersonalizationEventHandler.shared.registerPersonalizationEvent(eventName: eventName, urlScheme: data.redirectionUrl.asStringOrEmpty(), offerId: data.id, source: self?.personalizationEventSource)
                    }
                   // self?.handleBannerDeepLinkRedirections(url: data.redirectionUrl.asStringOrEmpty())
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
//                        self?.openStories(stories: stories.stories ?? [], storyIndex: stories.stories?.firstIndex(of: story) ?? 0){storyIndex,snapIndex,isFavorite in
//                            stories.setFavourite(isFavorite: isFavorite, storyIndex: storyIndex, snapIndex: snapIndex)
//                            (self?.dataSource?.dataSources?[safe: storiesIndex] as? TableViewDataSource<Stories>)?.models = [stories]
//                        }
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

