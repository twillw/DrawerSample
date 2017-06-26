
import PromiseKit

internal class TestListController: ListController {

    // MARK: internal methods
    
    internal override func loadListItems() -> Promise<[ListItem]> {
        
        return Promise {
            fulfill, reject in
            
            var items = [ListItem]()
            for i in 0..<20 {
                
                items.append(TestListItem(text: "Sample item \(i)"))
            }
            
            fulfill(items)
        }
    }

}

