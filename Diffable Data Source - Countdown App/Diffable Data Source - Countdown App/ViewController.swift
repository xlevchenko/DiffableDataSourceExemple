//
//  ViewController.swift
//  Diffable Data Source - Countdown App
//
//  Created by Olexsii Levchenko on 5/20/22.
//

import UIKit

class ViewController: UIViewController {
    
    //2
    enum Section {
        case main // one section for table view
    }
    
    private var tableView: UITableView!
    
    
    //1
    //define the UITableViewDiffableDataSource instance
    private var dataSource: UITableViewDiffableDataSource<Section, Int>!
    
    private var timer: Timer!
    private var startInterval = 10 //seconds

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureNavigationBar()
        configureTableView()
        configureDataSource()
    }
}


//MARK: Configure TableView
extension ViewController {
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .systemBackground
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
}


//MARK: Configure Navigation Bar
extension ViewController {
    private func configureNavigationBar() {
        navigationItem.title = "Countdown with Diffable Data Source"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startCoundown))
    }
}


//MARK: Configure DataSource
extension ViewController {
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Int>(tableView: tableView, cellProvider: { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            
            if item == -1 {
                cell.textLabel?.text = "App launched 🚀. All looks good so far with Crashlytic. 👍"
                cell.textLabel?.numberOfLines = 0
            } else {
                cell.textLabel?.text = "\(item)"
            }
            
            return cell
        })
        
        //set type  of animation of the data source
        dataSource.defaultRowAnimation = .fade // .automatic
        
//        //setup snapshot
//        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
//
//        //add section
//        snapshot.appendSections([.main])
//
//        //add items
//        snapshot.appendItems([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
//
//        //add applay
//        dataSource.apply(snapshot, animatingDifferences: true)
        startCoundown()
    }
    
    @objc private func startCoundown() {
        if timer != nil {
            timer.invalidate()
        }
        //configure the timer
        //set interval countdown
        //assign a method that gets called every second
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
        //reset our startingInterval
        startInterval = 10 //second
        
        //setup snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems([startInterval]) //start at 10
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    @objc private func decrementCounter() {
        //get access to the snapshot to manipulate data
        //snapshot is the "source of truth" for the table view's data
        var snapshot = dataSource.snapshot()
        
        guard startInterval > 0 else {
            timer.invalidate()
            ship()
            return
        }
        startInterval -= 1 // 10, 9, 8...
        snapshot.appendItems([startInterval]) // 9  is insserted in table view
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func ship() {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems([-1])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
