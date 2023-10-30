//
//  File.swift
//  
//
//  Created by Shmeel Ahmad on 14/08/2023.
//

import Foundation
import SmilesUtilities
import UIKit


struct SmilesExplorerHomeCellRegistration: CellRegisterable {
    
    func register(for tableView: UITableView) {
        tableView.registerCellFromNib(SmilesExplorerFooterTableViewCell.self, withIdentifier: "SmilesExplorerFooterTableViewCell", bundle: .module)

        tableView.registerCellFromNib(SmilesExplorerHomeTicketsTableViewCell.self, withIdentifier: "SmilesExplorerHomeTicketsTableViewCell", bundle: .module)
        
        tableView.registerCellFromNib(SmilesExplorerHomeDealsAndOffersTVC.self, withIdentifier: "SmilesExplorerHomeDealsAndOffersTVC", bundle: .module)
        
    }
    
}
