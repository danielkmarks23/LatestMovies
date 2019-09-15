import UIKit

protocol TablePresenting: TableViewProxyPresenting {
    
    func configureOnViewLoad(_ tableViewController: TableViewController, useDetails: Bool)
    func presentData(data: [Movie])
    func presentDetails(_ tableViewController: TableViewController, array: [(String, String)])
    func toggleHeartButton()
    
    var heartToggle: Bool { get }
}

class TablePresenter: TablePresenting {
    
    var tableView: UITableView?
    var barButtonItem: UIBarButtonItem?
    var list = [Movie]()
    var details = [(String, String)]()
    let cellCreation: (IndexPath, UITableView, TableViewCellViewModeling) -> UITableViewCell
    private var useDetails = false
    var heartToggle = false
    
    init(cellCreation: @escaping (IndexPath, UITableView, TableViewCellViewModeling) -> UITableViewCell) {
        
        self.cellCreation = cellCreation
    }
    
    func configureOnViewLoad(_ tableViewController: TableViewController, useDetails: Bool) {
        
        self.useDetails = useDetails
        
        if useDetails {
            let button = UIBarButtonItem(image: UIImage(named: "heart"), style: .plain, target: nil, action: nil)
            tableViewController.navigationItem.rightBarButtonItem  = button
            barButtonItem = tableViewController.navigationItem.rightBarButtonItem
        }
        
        
        tableView = tableViewController.tableView
        tableView?.rowHeight = UITableView.automaticDimension
        registerCells(tableViewController.tableView)
    }
    
    private func registerCells(_ tableView: UITableView) {
        
        let bundle = Bundle(for: TableViewController.self)
        
        let movieNib = UINib(nibName: movieTableViewCell, bundle: bundle)
        tableView.register(movieNib, forCellReuseIdentifier: movieTableViewCell)
        
        let detailNib = UINib(nibName: detailTableViewCell, bundle: bundle)
        tableView.register(detailNib, forCellReuseIdentifier: detailTableViewCell)
    }
    
    func presentData(data: [Movie]) {
        
        print(data)
        list = data
        tableView?.reloadData()
    }
    
    func presentDetails(_ tableViewController: TableViewController, array: [(String, String)]) {
        
        details = array
        presentImage()
        tableView?.reloadData()
    }
    
    private func presentImage() {
        
        let headerImageView = PosterImageView.init(frame: CGRect(x: 0, y: 0, width: (tableView?.frame.width)!, height: 100))
        
        headerImageView.load(path: details[0].1)
        headerImageView.contentMode = .scaleAspectFit
        
        tableView?.tableHeaderView = headerImageView
    }
    
    func toggleHeartButton() {
        
        if !heartToggle {
            barButtonItem?.image = UIImage(named: "heartFull")
        } else {
            barButtonItem?.image = UIImage(named: "heart")
        }
        
        heartToggle = !heartToggle
    }
}

extension TablePresenter: TableViewProxyPresenting {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if useDetails {
            return details.count - 1
        }
        
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if useDetails {
            
            let cellViewModel = DetailTableViewCellViewModel(title: details[indexPath.row + 1].0, info: details[indexPath.row + 1].1)
            let cell = cellCreation(indexPath, tableView, cellViewModel)
            cell.selectionStyle = .none
            return cell
        } else {
            
            let movie = list[indexPath.row]
            let cellViewModel = MovieTableViewCellViewModel(imagePath: movie.image ?? "", title: movie.title)
            let cell = cellCreation(indexPath, tableView, cellViewModel)
            cell.selectionStyle = .none
            return cell
        }
    }
}
