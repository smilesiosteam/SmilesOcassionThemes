//
//  File.swift
//  
//
//  Created by Shmeel Ahmad on 17/08/2023.
//

import Foundation
import SmilesOffers
import SmilesStoriesManager
public enum OccasionThemesHomeNavigationType {
    case payment, withTextPromo, withQRPromo, freeTicket
}

public protocol SmilesOccasionThemesHomeDelegate {
    
    func handleDeepLinkRedirection(redirectionUrl: String)
    func navigateToGlobalSearch()
    func navigateToLocation()
    func navigateToRewardPoint(personalizationEventSource: String?)

}
