
import UIKit

internal class DrawerMenu: CustomView {
    
    // MARK: Class Properties
    
    internal static let ViewName = "DrawerMenu"
    internal static let DefaultFrame = CGRect(x: 0, y: 0, width: 315, height: 667)
    
    
    // MARK: outlets
    
    @IBOutlet weak var menuItemContainer: UIView!
    
    
    // MARK: Constructors
    
    internal init() {
        super.init(viewName: DrawerMenu.ViewName, frame: DrawerMenu.DefaultFrame)
    }
    
    // only called when build from interface builder
    internal required init?(coder aDecoder: NSCoder) {
        super.init(viewName: DrawerMenu.ViewName, coder: aDecoder)
    }
    
    
    // MARK: Internal Methods
    
    internal func addMenuItem(_ account: Account, atIndex index: Int, onSelection action: @escaping (Int) -> Void) {
        
        // create new menu item view
        let menuItem = MenuItem(withNickname: account.name, andBan: "Account # \(account.ban)", itemIndex: index, action: action)
        
        // set up leading, trailing and top constraint for new menu item
        let leading = NSLayoutConstraint(item: menuItem, attribute: .leading, relatedBy: .equal, toItem: menuItemContainer, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailing = NSLayoutConstraint(item: menuItem, attribute: .trailing, relatedBy: .equal, toItem: menuItemContainer, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let height = NSLayoutConstraint(item: menuItem, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 60.0)
        var top = NSLayoutConstraint(item: menuItem, attribute: .top, relatedBy: .equal, toItem: menuItemContainer, attribute: .top, multiplier: 1.0, constant: 8.0)
        
        // get previously added menu item
        if let previousMenuItem = menuItemContainer.subviews.last {
            
            // anchor top to bottom of previous menu item
            top = NSLayoutConstraint(item: menuItem, attribute: .top, relatedBy: .equal, toItem: previousMenuItem, attribute: .bottom, multiplier: 1.0, constant: 8.0)
        }
        
        // add new menu item to container
        menuItem.translatesAutoresizingMaskIntoConstraints = false
        menuItemContainer.addSubview(menuItem)
        
        // add constraints to menu item
        menuItemContainer.addConstraints([leading, trailing, top, height])
    }
}
