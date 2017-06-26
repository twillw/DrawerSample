
import UIKit
import PromiseKit

internal class ListController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: instance properties
    
    @IBOutlet internal var tableView: UITableView!
    
    internal var listItems = [ListItem]()
    private var listItemPromise: Promise<[ListItem]>?
    
    
    // MARK: internal methods
    
    internal func loadListItems() -> Promise<[ListItem]> {
        
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

