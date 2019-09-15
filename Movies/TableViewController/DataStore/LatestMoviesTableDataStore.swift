import Foundation

class LatestMoviesTableDataStore: TableDataStoring {
    
    var array: [Codable]
    let manager: MovieManager
    
    init(manager: MovieManager) {
        
        self.manager = manager
        self.array = []
    }
    
    func load(_ completion: @escaping (([Codable]) -> Void), catchError errorHandling: @escaping (Error) -> Void) {
        
        manager.loadMovies({
            data in
            self.array = data
            completion(self.array)
        }, catchError: errorHandling)
    }
}
