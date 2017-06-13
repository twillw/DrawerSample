
import UIKit

internal class MobilityController: AccountController {

    
    // MARK: constructors
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: this is just for testing, these should be Usage, Travel etc.
        let test1 = UIStoryboard(name: "Test", bundle: nil).instantiateInitialViewController() as! TestController
        test1.labelText = "Test 1"
        test1.title = "Test 1"
        let test2 = UIStoryboard(name: "Test", bundle: nil).instantiateInitialViewController() as! TestController
        test2.labelText = "Test 2"
        test2.title = "Test 2"
        let test3 = UIStoryboard(name: "Test", bundle: nil).instantiateInitialViewController() as! TestController
        test3.labelText = "Test 3"
        test3.title = "Test 3"
        
        let controllers = [test1, test2, test3]
        
        // set view controllers
        self.setViewControllers(controllers, animated: false)
    }
}

