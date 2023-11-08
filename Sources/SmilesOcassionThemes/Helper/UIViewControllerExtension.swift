//
//  File.swift
//  
//
//  Created by Ghullam  Abbas on 08/11/2023.
//

import Foundation
import UIKit

extension UIViewController {

    /**
     *  Height of status bar + navigation bar (if navigation bar exist)
     */

    var occasionthemeTopbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
