
import UIKit

internal class HomeSolutionsController: AccountController {

    
    // MARK: lifecycle methods
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        let test4 = UIStoryboard(name: "Test", bundle: nil).instantiateInitialViewController() as! TestController
        test4.labelText = "Test 4"
        test4.title = "Test 4"
        let test5 = UIStoryboard(name: "Test", bundle: nil).instantiateInitialViewController() as! TestController
        test5.labelText = "Test 5"
        test5.title = "Test 5"
        
        setViewControllers([test4, test5], animated: false)
    }
}

