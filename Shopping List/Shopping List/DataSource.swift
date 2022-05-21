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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            //1. get the current snapshot
            var snapshot = self.snapshot()
            
            //2. get the item using  the item indentifaier
            if let item = itemIdentifier(for: indexPath) {
                //3. delete item from the snapshot
                snapshot.deleteItems([item])
                
                //4. apllt the snapshot (aplly changes  to the datasource which in turn updates the table view)
                apply(snapshot, animatingDifferences: true)
            }
        }
    }
    
    
}
