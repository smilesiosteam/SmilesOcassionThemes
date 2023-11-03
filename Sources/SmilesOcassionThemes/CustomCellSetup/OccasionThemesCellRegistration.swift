//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 04/09/2023.
//

import UIKit
import SmilesUtilities
import SmilesStoriesManager
import SmilesOffers

struct OccasionThemesCellRegistration: CellRegisterable {
    
    func register(for tableView: UITableView) {
        tableView.registerCellFromNib(SmilesExplorerStoriesTVC.self, bundle: .module)
        tableView.registerCellFromNib(TopBrandsTableViewCell.self, bundle: .module)
        tableView.registerCellFromNib(CollectionsTableViewCell.self, bundle: .module)
        tableView.registerCellFromNib(StoriesTableViewCell.self,bundle: StoriesTableViewCell.module)
        
//        tableView.registerCellFromNib(UpgradeBannerTVC.self, bundle: .module)
//        tableView.registerCellFromNib(RestaurantsRevampTableViewCell.self, bundle: RestaurantsRevampTableViewCell.module)
//        tableView.registerCellFromNib(FiltersTableViewCell.self, withIdentifier: String(describing: FiltersTableViewCell.self), bundle: FiltersTableViewCell.module)
    }
}
