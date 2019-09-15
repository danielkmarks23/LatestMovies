//
//  Movie.swift
//  Movies
//
//  Created by Daniel Marks on 15/07/2019.
//  Copyright © 2019 Daniel Marks. All rights reserved.
//

import Foundation

struct MoviesResult: Codable {
    
    var results: [Movie]
}

struct Movie: Codable {
    
    var title: String
    var rating: Double
    var description: String
    var image: String?
    var releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        
        case title
        case rating = "vote_average"
        case description = "overview"
        case image = "poster_path"
        case releaseDate = "release_date"
    }
}

extension Movie: Equatable {
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return
            lhs.title == rhs.title &&
            lhs.releaseDate == rhs.releaseDate
    }
}
