//
//  LikedMoviesTableDataStore.swift
//  Movies
//
//  Created by Daniel Marks on 17/07/2019.
//  Copyright © 2019 Daniel Marks. All rights reserved.
//

import Foundation

class LikedMoviesTableDataStore: TableDataStoring {
    
    var array: [Codable]
    
    init() {
        
        self.array = []
    }
    
    func load(_ completion: @escaping (([Codable]) -> Void), catchError errorHandling: @escaping (Error) -> Void) {
        
        let movies = Defaults.getLikedMovies()
        self.array = movies
        completion(movies)
    }
}
