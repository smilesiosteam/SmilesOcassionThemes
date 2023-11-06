//
//  File.swift
//  
//
//  Created by Habib Rehman on 22/08/2023.
//

import Foundation

public enum OcassionThemeEndpoints: String, CaseIterable {
    case getExclusiveOffer
    
}

extension OcassionThemeEndpoints {
    var serviceEndPoints: String {
        switch self {
        case .getExclusiveOffer:
            return "explorer/offers"
    
        }
    }
}
