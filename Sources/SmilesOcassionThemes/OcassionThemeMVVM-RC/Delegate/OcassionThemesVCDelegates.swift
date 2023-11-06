//
//  File.swift
//  
//
//  Created by Habib Rehman on 05/09/2023.
//

import Foundation
import UIKit
import SmilesUtilities
import SmilesSharedServices
import SmilesOffers
import SmilesStoriesManager

extension OcassionThemesVC: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let secID = OccasionThemesSectionIdentifier(rawValue: self.occasionThemesSectionsData?.sectionDetails?[safe: indexPath.section]?.sectionIdentifier ?? "") {
            switch secID {
            case .topBrands:
                break
               // self.onUpgradeBannerButtonClick()
            case .stories:
                break
            case .topCollections:
                if let dataSource = ((self.dataSource?.dataSources?[safe: indexPath.section] as? TableViewDataSource<OfferDO>)) {
                    if !dataSource.isDummy {
                        let offer = dataSource.models?[safe: indexPath.row] as? OfferDO
                     //   self.delegate?.proceedToOfferDetails(offer: offer)
                    }
                }
                break
            case .topPlaceholder:
                break
            case .themeItemCategories:
                break
            }

        }
        
        
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch self.occasionThemesSectionsData?.sectionDetails?[safe: indexPath.section]?.sectionIdentifier {
        case OccasionThemesSectionIdentifier.topPlaceholder.rawValue:
            return 130
        case OccasionThemesSectionIdentifier.stories.rawValue:
            return 170
            //UITableView.automaticDimension
        case OccasionThemesSectionIdentifier.topBrands.rawValue:
            return 124
        case OccasionThemesSectionIdentifier.topCollections.rawValue:
             return 210
        case OccasionThemesSectionIdentifier.themeItemCategories.rawValue:
             return 400
            //UITableView.automaticDimension
        default:
            return UITableView.automaticDimension
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
       // if self.dataSource?.tableView(tableView, numberOfRowsInSection: section) == 0 {return nil}
        
        if let sectionData = self.occasionThemesSectionsData?.sectionDetails?[safe: section] {
            
            if sectionData.sectionIdentifier != OccasionThemesSectionIdentifier.topPlaceholder.rawValue {
                if let sectionData = self.occasionThemesSectionsData?.sectionDetails?[safe: section] {
                    
                    let header = OccasionThemesHeaderView()
                    header.setupData(title: sectionData.title, subTitle: sectionData.subTitle, color: UIColor(hexString: sectionData.backgroundColor ?? ""), section: section, isPostSub: true)
//                    switch self.occasionThemesSectionsData?.sectionDetails?[safe: section]?.sectionIdentifier {
//                    case OccasionThemesSectionIdentifier.topPlaceholder.rawValue:
//                        break
//                    case OccasionThemesSectionIdentifier.stories.rawValue:
//                        break
//                    case OccasionThemesSectionIdentifier.topCollections.rawValue:
//                        break
//                    default:
//                        header.mainView.backgroundColor = .white
//                        
//                    }
                    configureHeaderForShimmer(section: section, headerView: header)
                    return header
                    
                }
            }
        }
        
        
        return OccasionThemesHeaderView()
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        if let offersIndex = getSectionIndex(for: .topPlaceholder) {
//            if section == offersIndex {
//                return 0
//            }
//        }
//        if let offersIndex = getSectionIndex(for: .themeItemCategories) {
//            if section == offersIndex {
//                return 0
//            }
//        }
        return CGFloat.leastNormalMagnitude
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if self.dataSource?.tableView(tableView, numberOfRowsInSection: section) == 0 {
//            return CGFloat.leastNormalMagnitude
//        }
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if let offersIndex = getSectionIndex(for: .topCollections) {
//            if indexPath.section == offersIndex {
//                let lastItem = self.bogoOffers.endIndex - 1
//                if indexPath.row == lastItem {
//                    if bogoOffers.count != (bogooffersListing?.offersCount ?? 0)  {
//                        offersPage += 1
//                       // self.input.send(.getBogoOffers(categoryId: self.categoryId, tag: .exclusiveDealsBogoOffers, pageNo: offersPage))
//                    }
//                }
//            }
//        }
    }
    
    func configureHeaderForShimmer(section: Int, headerView: UIView) {
        
        func showHide(isDummy: Bool) {
            if isDummy {
                headerView.enableSkeleton()
                headerView.showAnimatedGradientSkeleton()
            } else {
                headerView.hideSkeleton()
            }
        }
        
        
        if let sectionData = self.occasionThemesSectionsData?.sectionDetails?[safe: section] {
            switch OccasionThemesSectionIdentifier(rawValue: sectionData.sectionIdentifier ?? "") {
            case .stories:
                if let dataSource = (self.dataSource?.dataSources?[safe: section] as? TableViewDataSource<OcassionThemesOfferResponse>) {
                    showHide(isDummy: dataSource.isDummy)
                }
            case .topCollections:
                
                if let dataSource = (self.dataSource?.dataSources?[safe: section] as? TableViewDataSource<OfferDO>) {
                    showHide(isDummy: dataSource.isDummy)
                }
           
            
            default:
                break
            }
        }
        
    }
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
           // adjustTopHeader(scrollView)
    }
    
}
