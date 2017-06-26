
import UIKit
import PromiseKit

internal class ListController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: instance properties
    
    @IBOutlet internal var tableView: UITableView!
    
    internal var listItems = [ListItem]()
    private var listItemPromise: Promise<[ListItem]>?
    
    
    // MARK: lifecycle methods
    
    internal override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // configure data source and delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        _ = loadData()
            .then {
                [weak self = self] _ in
                
                // reload tableview on success
                self?.tableView.reloadData()
            }
    }
    
    
    // MARK: internal methods
    
    internal func loadListItems() -> Promise<[ListItem]> {
        // no-op this should be overridden
        fatalError("This should be overridden")
    }
    
    
    // MARK: private methods
    
    private func loadData(forceLive: Bool = false) -> Promise<[ListItem]> {
        
        if let promise = listItemPromise, forceLive == false {
            return promise
        }
        
        // cache load list item promise
        listItemPromise = loadListItems().then {
            [weak self = self]
            listItems -> [ListItem] in
            
                // set list items property
                self?.listItems = listItems
                return listItems
            }
        
            listItemPromise?.catch {
                [weak self = self]
                error in
                
                // set cached promise to nil if promise was rejected
                self?.listItemPromise = nil
            }
        
        return listItemPromise!
    }

  
    // MARK: UITableViewDataSource methods
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let listItem = listItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: listItem.cellIdentifier)
       
        if let listItemCell = cell as? ListItemCell {
            listItemCell.bind(item: listItem)
        }
        
        return cell ?? UITableViewCell()
    }
    
    
    // MARK: UITableViewDelegate methods
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = listItems[indexPath.row]
        item.onItemSelected()
    }
}

