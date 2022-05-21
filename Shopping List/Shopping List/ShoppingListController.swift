//
//  ShoppingListController.swift
//  Shopping List
//
//  Created by Olexsii Levchenko on 5/20/22.
//

import UIKit

class ShoppingListController: UIViewController {
    
    private var tableView: UITableView!
    private var dataSource: DataSource! //it the subclass we created
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
        configureDataSource()
        
    }
}


//MARK: Configure NavigationBar
extension ShoppingListController {
    private func configureNavigationBar() {
        navigationItem.title = "Shopping List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditState))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddVC))
    }
}


//MARK: Configure Table View
extension ShoppingListController {
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .systemBackground
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
}


//MARK: Configure DataSource
extension ShoppingListController {
    private func configureDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            cell.textLabel?.text = "\(item.name)"
            return cell
        })
        
        //setup type of animation
        dataSource.defaultRowAnimation = .fade

        //setup initial snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Category, Item>()
        
        //populate snapshot with sections and items for each section
        //caseIterable allows us to iterate through all the cases of an enum
        for category in Category.allCases {
            //query the testData() [items]  for that particula categoty's items
            let items = Item.testData().filter { item in
                item.category == category
            }
            snapshot.appendSections([category]) //add section to the table view
            snapshot.appendItems(items)
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    
    @objc private func toggleEditState() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        navigationItem.leftBarButtonItem?.title = tableView.isEditing ? "Done" : "Edit"
    }
    
    
    @objc private func presentAddVC() {
        guard let addItemVC = storyboard?.instantiateViewController(withIdentifier: "AddItemController") as? AddItemController else {
            return
        }
        addItemVC.delegate = self
        present(addItemVC, animated: true)
    }
}


extension ShoppingListController: AddItemControllerDelegate {
    func didAddNewItem(_ addItemViewConroller: AddItemController, item: Item) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems([item], toSection: item.category)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    
}
