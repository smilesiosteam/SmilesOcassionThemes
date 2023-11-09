//
//  File.swift
//  
//
//  Created by Ghullam  Abbas on 30/10/2023.
//

import Foundation
import UIKit

public struct SmilesOccasionThemesfigurator {
    
    public enum ConfiguratorType {
        case occasionThemesVC(delegate: SmilesOccasionThemesHomeDelegate?, themeId: Int)
    }
    
    public static func create(type: ConfiguratorType) -> UIViewController {
        switch type {
        case .occasionThemesVC(let delegate, let themeId):
            return OcassionThemesVC(delegate: delegate, themeId: themeId)
        }
    }
    
}

