
import UIKit

internal class TestController: UIViewController {

    // MARK: instance variables
    
    internal var labelText: String!
    
    
    // MARK: outlets

    @IBOutlet weak var label: UILabel!
    
  
    // MARK: lifecycle methods
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = labelText
    }
}

