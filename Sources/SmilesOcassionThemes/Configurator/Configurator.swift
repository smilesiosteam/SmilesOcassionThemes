//
//  File.swift
//  
//
//  Created by Ghullam  Abbas on 30/10/2023.
//

import Foundation
import UIKit
import SmilesUtilities

public struct SmilesOccasionThemesfigurator {
   public enum ConfiguratorType {
       case occasionThemesVC(delegate: SmilesOccasionThemesHomeDelegate?)
    }
    
    public static func create(type: ConfiguratorType) -> UIViewController {
        switch type {
        case .occasionThemesVC(let delegate):
            return OcassionThemesVC(delegate: delegate!)
        }
        
    }
    
}

