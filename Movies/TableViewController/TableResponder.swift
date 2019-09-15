//
//  TableResponder.swift
//  Movies
//
//  Created by Daniel Marks on 16/07/2019.
//  Copyright © 2019 Daniel Marks. All rights reserved.
//

import UIKit

protocol TableResponding: TableViewProxyResponding {
    
    var didSelectRow: ((IndexPath) -> Void)? { get set }
    var didTapHeartButton: (() -> Void)? { get set }
    
    func configureOnViewLoad(_ viewController: UIViewController)
}

class TableResponder: TableResponding {
    
    var didSelectRow: ((IndexPath) -> Void)?
    var didTapHeartButton: (() -> Void)?
    
    func configureOnViewLoad(_ viewController: UIViewController) {
        
        viewController.navigationItem.rightBarButtonItem?.target = self
        viewController.navigationItem.rightBarButtonItem?.action = #selector(tappedHeartButton)
    }
    
    @objc func tappedHeartButton() {
        
        didTapHeartButton?()
    }
}

extension TableResponder: TableViewProxyResponding {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        didSelectRow?(indexPath)
    }
}
