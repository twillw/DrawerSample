

internal class TestListItem: ListItem {

    // MARK: instance properties
    
    internal let cellIdentifier: String = "TestCell"
    internal let text: String
    
    
    // MARK: constructors
    
    internal init(text: String) {
        self.text = text
    }
    
  
    // MARK: instance methods
    
    internal func onItemSelected() {
        
        // no-op
    }

}

