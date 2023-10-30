//
//  File.swift
//  
//
//  Created by Shmeel Ahmad on 17/08/2023.
//

import Foundation
import SmilesOffers
import SmilesStoriesManager
public enum SmilesExplorerHomeNavigationType {
    case payment, withTextPromo, withQRPromo, freeTicket
}

public protocol SmilesOccasionThemesHomeDelegate {
    
    func proceedToPayment(params: SmilesExplorerPaymentParams, navigationType:SmilesExplorerHomeNavigationType)
    func handleDeepLinkRedirection(redirectionUrl: String)
    
    func navigateToGlobalSearch()
    func navigateToLocation()
    func navigateToRewardPoint(personalizationEventSource: String?)
    func proceedToOfferDetails(offer: OfferDO?)
    func navigateToStoriesWebView(objStory: ExplorerOffer)
    func navigateToExplorerHome()
    func navigateToFilter(selectedOfferCategoryIndex: Int, arraySelectedSubCategoryPAths: [IndexPath], sortingType: String?)
    func navigateToSortingVC(selectedSortTypeIndex: Int?, selectedOfferCategoryIndex: Int, arraySort: [String], isChangeSortType: Bool)

}
