import UIKit

public class TableViewController: UIViewController {
    
    var coordinator: TableCoordinator!
    
    @IBOutlet weak var tableView: UITableView!
    
    init(coordinator: TableCoordinator) {
        
        self.coordinator = coordinator
        
        let nibName = "TableViewController"
        let bundle = Bundle(for: TableViewController.self)
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) is not implemented for TableViewController")
    }
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
        
        coordinator.viewControllerViewDidLoad(tableViewController: self)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        coordinator.viewControllerViewWillAppear(tableViewController: self)
    }
}
