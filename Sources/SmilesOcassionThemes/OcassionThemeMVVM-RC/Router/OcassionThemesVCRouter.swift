//
//  File.swift
//  
//
//  Created by Shmeel Ahmad on 14/08/2023.
//


import SmilesSharedServices
import SmilesUtilities
import UIKit

@objcMembers
public final class SmilesExplorerRouter: NSObject {
    
    public static let shared = SmilesExplorerRouter()
    
    private override init() {}
    
}


public class CustomPresentationController: UIPresentationController {
    public override var frameOfPresentedViewInContainerView: CGRect {
        // Customize the frame here as per your requirements
        return CGRect(x: 20, y: 100, width:UIScreen.main.bounds.width, height: 300)
    }
}
