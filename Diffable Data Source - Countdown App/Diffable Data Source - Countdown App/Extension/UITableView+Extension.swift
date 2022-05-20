//
//  UITableView+Extension.swift
//  Diffable Data Source - Countdown App
//
//  Created by Olexsii Levchenko on 5/20/22.
//

import UIKit

extension UITableView {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
