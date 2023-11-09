//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 09/11/2023.
//

import Foundation
import SmilesBaseMainRequestManager

class TopPlaceholderThemeRequest: SmilesBaseMainRequest {
    
    // MARK: - Model Variables
    var themeId: Int?
    
    // MARK: - Model Keys
    
    enum CodingKeys: CodingKey {
        case themeId
    }
    
    init(themeId: Int?) {
        super.init()
        self.themeId = themeId
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.themeId, forKey: .themeId)
    }
}

