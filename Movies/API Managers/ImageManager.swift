//
//  ImageManager.swift
//  Movies
//
//  Created by Daniel Marks on 16/07/2019.
//  Copyright © 2019 Daniel Marks. All rights reserved.
//

import Foundation

class ImageManager {
    
    private var baseURL = "https://image.tmdb.org/t/p/w92"
    var webService = WebService()
    
    func loadImage(imagePath: String, completion: @escaping ((Data) -> Void), catchError errorHandling: @escaping (Error) -> Void) {
        
        let url = baseURL + imagePath
        
        webService.loadData(url: url, completion: completion, catchError: errorHandling)
    }
}
