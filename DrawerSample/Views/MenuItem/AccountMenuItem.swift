
import UIKit

internal class AccountMenuItem: CustomView, MenuItem {
    
    // MARK: Class Properties
    
    internal static let ViewName = "AccountMenuItem"
    internal static let DefaultFrame = CGRect(x: 0, y: 0, width: 300, height: 60)
    
    
    // MARK: instance variables
    
    internal var type: MenuItemType!
    private var onItemSelected: ((MenuItemType) -> Void)?
    private var itemIndex: Int = 0
    private var account: Account!
    
    
    // MARK: outlets
    
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var banLabel: UILabel!
    
    
    // MARK: Constructors
    
    internal init(account: Account, action onItemSelected: ((MenuItemType) -> Void)?, type: MenuItemType) {
        
        // set instance variables
        self.onItemSelected = onItemSelected
        self.account = account
        self.type = type
        
        super.init(viewName: AccountMenuItem.ViewName, frame: AccountMenuItem.DefaultFrame)
        
        // bind data to labels
        nicknameLabel.text = account.name
        banLabel.text = account.ban
    }
    
    // only called when build from interface builder
    internal required init?(coder aDecoder: NSCoder) {
        super.init(viewName: AccountMenuItem.ViewName, coder: aDecoder)
    }
    
    
    // MARK: actions
    
    @IBAction func itemSelected(_ sender: Any) {
        onItemSelected?(type)
    }
}

