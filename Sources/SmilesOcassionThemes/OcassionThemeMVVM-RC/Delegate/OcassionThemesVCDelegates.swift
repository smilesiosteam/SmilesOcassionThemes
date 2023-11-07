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
            return 0
        case OccasionThemesSectionIdentifier.stories.rawValue:
            return 170
        case OccasionThemesSectionIdentifier.topBrands.rawValue:
            return 124
        case OccasionThemesSectionIdentifier.topCollections.rawValue:
             return 210
        case OccasionThemesSectionIdentifier.themeItemCategories.rawValue:
            return 400
        default:
            return UITableView.automaticDimension
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch self.occasionThemesSectionsData?.sectionDetails?[safe: section]?.sectionIdentifier {
        case OccasionThemesSectionIdentifier.topPlaceholder.rawValue:
            return 40
        
        default:
            return .leastNormalMagnitude
        }
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
       // if self.dataSource?.tableView(tableView, numberOfRowsInSection: section) == 0 {return nil}
        
        if let sectionData = self.occasionThemesSectionsData?.sectionDetails?[safe: section] {
                if let sectionData = self.occasionThemesSectionsData?.sectionDetails?[safe: section] {
                    if  self.occasionThemesSectionsData?.sectionDetails?[safe: section]?.sectionIdentifier == OccasionThemesSectionIdentifier.topPlaceholder.rawValue{
                        let header = OcassionThemeHeaderView()
                        header.dateLabel.text = "18th-12th Septemper"
                        header.themeTitleLabel.text = sectionData.title
                        header.themeDescLabel.text = sectionData.subTitle
                        return header
                    
                    } else {
                        let header = OccasionThemesTableViewHeaderView()
                        header.setupData(title: sectionData.title, subTitle: sectionData.subTitle, color: UIColor(hexString: sectionData.backgroundColor ?? ""), section: section, isPostSub: true)
                        configureHeaderForShimmer(section: section, headerView: header)
                        return header
                    }
                    
                }
        }
        return OccasionThemesTableViewHeaderView()
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if let offersIndex = getSectionIndex(for: .topPlaceholder) {
            if section == offersIndex {
                return 232
            }
        }
        return CGFloat.leastNormalMagnitude
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if let sectionData = self.occasionThemesSectionsData?.sectionDetails?[safe: section] {
            switch OccasionThemesSectionIdentifier(rawValue: sectionData.sectionIdentifier ?? "") {
            case .topPlaceholder:
                return 232
            default:
                return UITableView.automaticDimension
            }
        }
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
                if let dataSource = (self.dataSource?.dataSources?[safe: section] as? TableViewDataSource<Stories>) {
                    showHide(isDummy: dataSource.isDummy)
                }
            case .topCollections:
                if let dataSource = (self.dataSource?.dataSources?[safe: section] as? TableViewDataSource<OfferDO>) {
                    showHide(isDummy: dataSource.isDummy)
                }
            case .topBrands:
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
