
import UIKit

internal class TestListItemCell: UITableViewCell, ListItemCell {

    // MARK: instance methods
    
    internal func bind(item: ListItem) {
        
        guard let testItem = item as? TestListItem else { return }
        
        textLabel?.text = testItem.text
    }
}

