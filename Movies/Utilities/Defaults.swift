//
//  Defaults.swift
//  Movies
//
//  Created by Daniel Marks on 17/07/2019.
//  Copyright © 2019 Daniel Marks. All rights reserved.
//

import Foundation

struct Defaults {
    
    static let key = "likedMovies"
    
    static func save(movie: Movie) {
        
        var movies = getLikedMovies()
        movies.append(movie)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(movies), forKey: key)
    }
    
    static func getLikedMovies() -> [Movie] {
        
        guard let moviesData = UserDefaults.standard.object(forKey: key) as? Data,
        let movies = try? PropertyListDecoder().decode([Movie].self, from: moviesData) else {
            return []
        }
        
        return movies
    }
    
    static func removeMovie(movie: Movie) {
        
        var movies = getLikedMovies()
        movies = movies.filter { $0.title != movie.title && $0.releaseDate != movie.releaseDate }
        UserDefaults.standard.set(try? PropertyListEncoder().encode(movies), forKey: key)
    }
    
    static func clearUserData() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
