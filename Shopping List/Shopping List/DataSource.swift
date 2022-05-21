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
    
    
    //1. reordering steps
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //2. reordering steps
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //get the source item
        guard let sourceItem = itemIdentifier(for: sourceIndexPath) else { return }
        
        // SCENARIO 1: attempting to move to self
        guard sourceIndexPath != destinationIndexPath else { return }
        
        //get the destination item
        let destinationItem = itemIdentifier(for: destinationIndexPath)
        
        //get get current snapshot
        var snapshot = self.snapshot()
        
        //handle SCENARIO 2 and 3
        if let destinationItem = destinationItem {
            
            //get the source index and the destination index
            if let sourceIndex = snapshot.indexOfItem(sourceItem),
               let destinationIndex = snapshot.indexOfItem(destinationItem) {
                
                //what order should we be inserting the source item
                let isAfter = destinationIndex > sourceIndex && snapshot.sectionIdentifier(containingItem: sourceItem) == snapshot.sectionIdentifier(containingItem: destinationItem)
                
                //first delete the source item from the snapshot
                snapshot.deleteItems([sourceItem])
                
                //SCENARIO 2
                if isAfter {
                    snapshot.insertItems([sourceItem], afterItem: destinationItem)
                } else {
                    //SCENARIO 3
                    snapshot.insertItems([sourceItem], beforeItem: destinationItem)
                }
            }
            
            //handle SCENARIO 4
            //no index path at destination section
        } else {
            //get the section for the destination index path
            let destinationSectionIdentifier = snapshot.sectionIdentifiers[destinationIndexPath.section]
            
            //delete the source item before reinserting it
            snapshot.deleteItems([sourceItem])
            
            //append the source item at the new section
            snapshot.appendItems([sourceItem], toSection: destinationSectionIdentifier)
        }
        //apply changes to the data source
        apply(snapshot, animatingDifferences: false)
    }
}
