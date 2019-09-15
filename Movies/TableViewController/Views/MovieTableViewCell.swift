//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Daniel Marks on 16/07/2019.
//  Copyright © 2019 Daniel Marks. All rights reserved.
//

import UIKit

public let movieTableViewCell = "MovieTableViewCell"

protocol TableViewCellViewModeling {
    
    var title: String { get set }
}

public struct MovieTableViewCellViewModel: TableViewCellViewModeling {
    
    var imagePath: String
    var title: String
    
    init(imagePath: String, title: String) {
        
        self.imagePath = imagePath
        self.title = title
    }
}

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: PosterImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    public func setup(with viewModel: MovieTableViewCellViewModel) {
        
        posterImageView.load(path: viewModel.imagePath)
        posterImageView.contentMode = .scaleAspectFit
        titleLabel.text = viewModel.title
    }
}
