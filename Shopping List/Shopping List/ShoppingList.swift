//
//  ShoppingList.swift
//  Shopping List
//
//  Created by Olexsii Levchenko on 5/20/22.
//

import UIKit

class ShoppingList: UIViewController {
    
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
extension ShoppingList {
    private func configureNavigationBar() {
        navigationItem.title = "Shopping List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditState))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddVC))
    }
}


//MARK: Configure Table View
extension ShoppingList {
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .systemBackground
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
}


//MARK: Configure DataSource
extension ShoppingList {
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
        
    }
    
    @objc private func presentAddVC() {
        //1. Create a AddItemViewController.swift file
        //2. add a ViewController object in a Storyboard
        //3. add to textfield, one for item name and other  for price
        //4. add a picker view to manage the categories
        //5. user is able to add new item to a given category and a click on a submmit button
        //6. use any communiction protocol to get data from AddItemViewController back to the ViewController
        // types: (delegation, KVO, notification center, unwin segue, callback, combine)
    }
}
