import UIKit

@objc protocol TableViewProxyPresenting {
    
    @objc optional func numberOfSections(in tableView: UITableView) -> Int
    @objc optional func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    @objc optional func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    @objc optional func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    @objc optional func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    @objc optional func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    @objc optional func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
}

@objc protocol TableViewProxyResponding {
    
    @objc optional func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
}

class ManualSizingTableViewProxy: NSObject {
    
    let presenter: TableViewProxyPresenting
    let responder: TableViewProxyResponding
    init(presenter: TableViewProxyPresenting, responder: TableViewProxyResponding) {
        self.presenter = presenter
        self.responder = responder
    }
}

extension ManualSizingTableViewProxy: UITableViewDelegate {
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        responder.tableView?(tableView, didSelectRowAt: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return presenter.tableView?(tableView, viewForHeaderInSection: section)
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return presenter.tableView?(tableView, heightForHeaderInSection: section) ?? 0
    }
    
    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return presenter.tableView?(tableView, titleForHeaderInSection: section)
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return presenter.tableView?(tableView, heightForRowAt: indexPath) ?? 0
    }
}

extension ManualSizingTableViewProxy: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        return presenter.numberOfSections?(in: tableView) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter.tableView?(tableView, numberOfRowsInSection: section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return presenter.tableView?(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
}

class SelfSizingTableViewProxy: NSObject {
    
    let presenter: TableViewProxyPresenting
    let responder: TableViewProxyResponding
    
    init(presenter: TableViewProxyPresenting, responder: TableViewProxyResponding) {
        
        self.presenter = presenter
        self.responder = responder
    }
}

extension SelfSizingTableViewProxy: UITableViewDelegate {
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        responder.tableView?(tableView, didSelectRowAt: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
    }
    
    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return presenter.tableView?(tableView, titleForHeaderInSection: section)
    }
}

extension SelfSizingTableViewProxy: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        return presenter.numberOfSections?(in: tableView) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter.tableView?(tableView, numberOfRowsInSection: section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return presenter.tableView?(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
}
