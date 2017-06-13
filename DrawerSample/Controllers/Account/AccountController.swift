
import UIKit

internal enum AccountType {
    case Mobility
    case HomeSolutions
}


internal class Account {
    
    internal let ban: String
    internal let name: String
    internal let type: AccountType
    
    internal init(ban: String, name: String, type: AccountType) {
        self.ban = ban
        self.name = name
        self.type = type
    }
}

internal class AccountController: UITabBarController {

    // MARK: instance variables
    
    internal var account: Account!

    
    // MARK: constructors
    
    internal convenience init(account: Account) {
        
        // call designated initializer
        self.init()
    }
    
    
    // MARK: lifecycle methods
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    // MARK: instance methods
    

}

