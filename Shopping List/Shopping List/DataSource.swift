//
//  DataSource.swift
//  Shopping List
//
//  Created by Olexsii Levchenko on 5/20/22.
//

import UIKit

//conforms to UITableViewDataSource
class DataSource: UITableViewDiffableDataSource<Category, Item> {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if Category.allCases[section] == .shoppingCart {
            return "🛒 " + Category.allCases[section].rawValue
        } else {
            return Category.allCases[section].rawValue
        }
    }
}
