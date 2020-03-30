//
//  UITableView+Extension.swift
//  GitHubFollowers
//
//  Created by Jose Alberto Ruíz-Carrillo González on 30/03/2020.
//  Copyright © 2020 JARCG. All rights reserved.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThreat() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func removeExcesCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
