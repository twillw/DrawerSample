
import UIKit


internal class Account {
    internal let ban: String
    internal let name: String
    
    internal init(ban: String, name: String) {
        self.ban = ban
        self.name = name
    }
}

internal class AccountController: UITabBarController {

    // MARK: instance variables
    
    internal var account: Account!

    
    // MARK: constructors
    
    internal convenience init(controllers: [UIViewController]) {
        
        // call designated initializer
        self.init()
        
        // set instance variables
        self.setViewControllers(controllers, animated: false)
    }
    
    
    // MARK: lifecycle methods
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    // MARK: instance methods
    

}

