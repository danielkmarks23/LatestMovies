//
//  MovieManager.swift
//  Movies
//
//  Created by Daniel Marks on 15/07/2019.
//  Copyright © 2019 Daniel Marks. All rights reserved.
//

import Foundation

class MovieManager {
    
    private var baseURL = "https://api.themoviedb.org/3"
    var webService = WebService()
    
    func loadMovies(_ completion: @escaping (([Movie]) -> Void), catchError errorHandling: @escaping (Error) -> Void) {
        
        let url = baseURL + "/discover/movie?api_key=\(webService.apiKey)&language=en-US&region=IL&sort_by=release_date.desc&page=1&primary_release_date.lte=\(Date().toString())"
        webService.load(url: url, completion: { (result: MoviesResult) in
            
            completion(result.results)
        }, catchError: errorHandling)
    }
}
