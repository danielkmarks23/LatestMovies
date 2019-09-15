import UIKit

protocol TableAssembling {
    
    func latestMoviesViewController() -> TableViewController
}

class TableAssembler: TableAssembling {
    
    var manager = MovieManager()
    
    func latestMoviesViewController() -> TableViewController {
        
        let dataStore = LatestMoviesTableDataStore(manager: manager)
        let cellCreation: (IndexPath, UITableView, TableViewCellViewModeling) -> UITableViewCell = { indexPath, tableView, cellViewModel in
            
             if let cell = tableView.dequeueReusableCell(withIdentifier: movieTableViewCell, for: indexPath) as? MovieTableViewCell, let cellViewModel = cellViewModel as? MovieTableViewCellViewModel {
                
                cell.setup(with: cellViewModel)
                return cell
            }
            
            return UITableViewCell()
        }
        
        let presenter = TablePresenter(cellCreation: cellCreation)
        return tableViewController(dataStore: dataStore, presenter: presenter)
    }
    
    func movieDetailsViewController(movie: Movie) -> TableViewController {
        
        let cellCreation: (IndexPath, UITableView, TableViewCellViewModeling?) -> UITableViewCell = { indexPath, tableView, cellViewModel in
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: detailTableViewCell, for: indexPath) as? DetailTableViewCell, let cellViewModel = cellViewModel as? DetailTableViewCellViewModel {
                
                cell.setup(with: cellViewModel)
                return cell
            }
            
            return UITableViewCell()
        }
        
        let presenter = TablePresenter(cellCreation: cellCreation)
        return tableViewController(presenter: presenter, movie: movie, useDetails: true)
    }
    
    func likedMoviesViewController() -> TableViewController {
        
        let dataStore = LikedMoviesTableDataStore()
        let cellCreation: (IndexPath, UITableView, TableViewCellViewModeling) -> UITableViewCell = { indexPath, tableView, cellViewModel in
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: movieTableViewCell, for: indexPath) as? MovieTableViewCell, let cellViewModel = cellViewModel as? MovieTableViewCellViewModel {
                
                cell.setup(with: cellViewModel)
                return cell
            }
            
            return UITableViewCell()
        }
        
        let presenter = TablePresenter(cellCreation: cellCreation)
        return tableViewController(dataStore: dataStore, presenter: presenter)
    }
    
    private func tableViewController(dataStore: TableDataStoring? = nil,
                                     presenter: TablePresenting,
                                     movie: Movie? = nil,
                                     useDetails: Bool = false) -> TableViewController {
        
        let responder = TableResponder()
        
        let coordinator = TableCoordinator(presenter: presenter,
                                           responder: responder,
                                           dataStore: dataStore,
                                           movie: movie,
                                           useDetails: useDetails)
        let viewController = TableViewController(coordinator: coordinator)
        
        return viewController
    }
}
