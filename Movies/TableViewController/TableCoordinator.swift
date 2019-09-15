import UIKit

class TableCoordinator {
    
    weak var tableViewController: TableViewController?
    var tableViewProxy: SelfSizingTableViewProxy?
    let presenter: TablePresenting
    let responder: TableResponding
    let dataStore: TableDataStoring?
    let movie: Movie?
    let useDetails: Bool
    
    required init(presenter: TablePresenting,
                  responder: TableResponding,
                  dataStore: TableDataStoring?,
                  movie: Movie?,
                  useDetails: Bool = false) {
        
        self.presenter = presenter
        self.responder = responder
        self.dataStore = dataStore
        self.movie = movie
        self.useDetails = useDetails

        configureOnInit()
    }
    
    private func configureOnInit() {
        
        responder.didSelectRow = { [weak self] indexPath in
            self?.indexPathSelected(indexPath: indexPath)
        }
        
        responder.didTapHeartButton = { [weak self] in
            
            self?.toggleHeartButton()
        }
    }
    
    private func toggleHeartButton() {
        
        self.presenter.toggleHeartButton()
        
        if self.presenter.heartToggle {
            Defaults.save(movie: self.movie!)
        } else {
            Defaults.removeMovie(movie: self.movie!)
        }
    }
    
    private func configureOnViewLoad(tableViewController: TableViewController) {
        
        self.tableViewController = tableViewController
        
        tableViewProxy = SelfSizingTableViewProxy(presenter: presenter, responder: responder)
        tableViewController.tableView.dataSource = tableViewProxy
        tableViewController.tableView.delegate = tableViewProxy
        
        presenter.configureOnViewLoad(tableViewController, useDetails: useDetails)
        responder.configureOnViewLoad(tableViewController)
    }
    
    private func configureOnViewWillAppear(tableViewController: TableViewController) {
        
        if useDetails {
            setupInfo()
        } else {
            load()
        }
    }
    
    private func load() {
        
        dataStore?.load({ [unowned self] data in
            
            if let movies = data as? [Movie] {
                DispatchQueue.main.async {
                    self.presenter.presentData(data: movies)
                }
            }
            }, catchError: { error in
                print(error)
        })
    }
    
    private func setupInfo() {
        
        guard let movie = movie else {
            return
        }
        
        if checkIfMovieIsLiked() {
            self.presenter.toggleHeartButton()
        }
        
        let array = [("Image", movie.image ?? ""),
                     ("Title", movie.title),
                     ("Description", movie.description),
                     ("Year", String(movie.releaseDate.prefix(4))),
                     ("Rating", String(movie.rating))]
        self.presenter.presentDetails(tableViewController! ,array: array)
    }
    
    private func checkIfMovieIsLiked() -> Bool {
        
        guard let movie = movie else {
            return false
        }
        
        let movies = Defaults.getLikedMovies()
        
        return movies.contains(movie)
    }
    
    private func indexPathSelected(indexPath: IndexPath) {
        
        if let items = dataStore?.array, let item = items[indexPath.row] as? Movie, let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            
            
            let viewController = appDelegate.assembler.movieDetailsViewController(movie: item)
        self.tableViewController?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func viewControllerViewDidLoad(tableViewController: TableViewController) {
        
        configureOnViewLoad(tableViewController: tableViewController)
    }
    
    func viewControllerViewWillAppear(tableViewController: TableViewController) {
        
        configureOnViewWillAppear(tableViewController: tableViewController)
    }
}
