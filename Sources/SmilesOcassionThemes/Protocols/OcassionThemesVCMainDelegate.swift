//
//  File.swift
//  
//
//  Created by Shmeel Ahmad on 17/08/2023.
//

import Foundation
import SmilesStoriesManager

public protocol SmilesOccasionThemesHomeDelegate {
    
    func handleDeepLinkRedirection(redirectionUrl: String)
    func navigateToGlobalSearch()
    func navigateToStoriesDetailVC(stories: [Story]?, storyIndex: Int?, favouriteUpdatedCallback: ((_ storyIndex: Int, _ snapIndex: Int, _ isFavourite: Bool) -> Void)?)


}
