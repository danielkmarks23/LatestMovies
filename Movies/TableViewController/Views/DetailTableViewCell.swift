//
//  DetailTableViewCell.swift
//  Movies
//
//  Created by Daniel Marks on 16/07/2019.
//  Copyright © 2019 Daniel Marks. All rights reserved.
//

import UIKit

public let detailTableViewCell = "DetailTableViewCell"

public struct DetailTableViewCellViewModel: TableViewCellViewModeling {
    
    var title: String
    var info: String
    
    init(title: String, info: String) {
        
        self.title = title
        self.info = info
    }
}

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    public func setup(with viewModel: DetailTableViewCellViewModel) {
        
        titleLabel.text = viewModel.title
        infoLabel.text = viewModel.info
//        infoLabel.sizeToFit()
    }
}
