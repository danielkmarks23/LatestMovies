//
//  PosterImageView.swift
//  Movies
//
//  Created by Daniel Marks on 16/07/2019.
//  Copyright © 2019 Daniel Marks. All rights reserved.
//

import UIKit

class PosterImageView: UIImageView {
    
    var path: String!
    var imageManager = ImageManager()
    
    func load(path: String) {
        
        if path == "" {
            self.image = UIImage()
            return
        }
        
        if path != self.path {
            
            self.path = path
            
            imageManager.loadImage(imagePath: path, completion: { data in
                
                if let image = UIImage(data: data) {
                    
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }) { error in
                print(error)
            }
        }
    }
}
