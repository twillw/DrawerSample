
import UIKit

internal class DrawerCoordinatorController: UIViewController, UIGestureRecognizerDelegate {

    // MARK: constants
    
    private let OpenDrawerTrailingSpace: CGFloat = 60
    
    
    // MARK: Outlets
    
    @IBOutlet weak var containerView: UIView!
    
    
    // MARK: instance variables
    
    private var drawerMenu: DrawerMenu!
    private var closedDrawerFrame: CGRect!
    private var overlay: UIView!
    
    private var isOpen = false
    private var accounts = [Account]()
    private var currentlySelectedController: UIViewController!
    
    
    // MARK: lifecycle methods
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize drawer menu
        initializeDrawer()
        
        
        // TODO: these will be added externally
        var accounts = [Account]()
        // add accounts
        for i in 1..<20 {
            
            let account1 = Account(ban: "12345", name: "\(i) Jimmy", type: .Mobility)
//            let account2 = Account(ban: "67890", name: "Second Jimmy", type: .HomeSolutions)
            accounts.append(account1)
        }
        
        addAccounts(accounts: accounts)
        
        // select first item by default
        setDefaultController()
    }
    
    
    // MARK: actions

    @IBAction internal func openDrawer(_ sender: Any) {
        
        // move overlay into frame
        overlay.frame = CGRect(x: 0, y: 0, width: overlay.frame.width, height: overlay.frame.height)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            [weak self = self] in
            
            guard let instance = self else { return }
            
            // animate overlay background
            instance.overlay.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.25)
            
            // animate drawer slide in
            instance.drawerMenu.frame = CGRect(x: 0, y: 0, width: instance.drawerMenu.frame.width,
                height: instance.drawerMenu.frame.height)
            
        },
        completion: { _ in
            // set is open to true
            self.isOpen = true
        })
    }
    
    // MARK: instance methods
    
    internal func tapReceived(sender: UITapGestureRecognizer) {
        
        // close burger menu
        closeDrawer()
    }
    
    
    // MARK: private methods
    
    private func initializeDrawer() {
        
        guard let rootView = navigationController?.view else {
            fatalError("This should always be inside a nav controller")
        }
        
        // create drawer menu
        drawerMenu = DrawerMenu()
        
        // calculate and set initial drawer frame
        let drawerWidth = rootView.frame.width - OpenDrawerTrailingSpace
        let drawerXOrigin = 0 - drawerWidth
        closedDrawerFrame = CGRect(x: drawerXOrigin, y: 0, width: drawerWidth, height: rootView.frame.height)
        drawerMenu?.frame = closedDrawerFrame
        
        // create overlay
        overlay = UIView(frame: CGRect(x: -rootView.frame.width, y: 0, width: rootView.frame.width,
            height: rootView.frame.height))
        overlay.backgroundColor = UIColor.clear
        
        // add drawer to overlay
        overlay?.addSubview(drawerMenu)
        
        // add overlay to rootView
        rootView.addSubview(overlay)
        
        // register to handle touches on overlay
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(DrawerCoordinatorController.tapReceived))
        tapRecognizer.delegate = self
        overlay.addGestureRecognizer(tapRecognizer)
    }
    
    private func closeDrawer() {
        
        guard let rootView = navigationController?.view else { return }
        
        // reset trailing constraint of burger view to be lower priority than width constraint
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            [weak self = self] in
            
            guard let instance = self else { return }
            
            instance.overlay.backgroundColor = UIColor.clear
            instance.drawerMenu.frame = instance.closedDrawerFrame
        },
        completion: { [weak self = self] _ in
            
            // move overlay out of viewport
            self?.overlay.frame = CGRect(x: -rootView.frame.width, y: 0, width: rootView.frame.width, height: rootView.frame.height)
            
            // set is open to true
            self?.isOpen = true
        })
        
        // set is open to false
        isOpen = false
    }
    
    internal func addAccounts(accounts: [Account]) {
        
        // iterate over controllers and add them
        for account in accounts {
            addAccount(account: account)
        }
    }
    
    private func addAccount(account: Account) {
        
        // add account to list
        accounts.append(account)
        
        // get type based on account type
        let type: MenuItemType = account.type == .Mobility
            ? .Mobility(account: account)
            : .HomeSolutions(account: account)
        
        // add link to controller in nav menu
        drawerMenu.addMenuItem(account, type: type, onSelection: onNavItemSelected)
    }
    
    private func onNavItemSelected(itemType: MenuItemType) {
        
        // TODO: check if item is already selected
        
        var controller: UIViewController!
        switch itemType {
        case .Mobility(let account):
            // create mobility account controller
            controller = MobilityController(account: account)
            break
        case .HomeSolutions(let account):
            // create home solutions account controller
            controller = HomeSolutionsController(account: account)
            break
        }
        
        transitionFrom(controller: currentlySelectedController, toController: controller)
        
        // close burger menu
        closeDrawer()
    }
    
    private func setDefaultController() {
        
        // if accountControllers is not empty get the first
        if let firstAccount = accounts.first {
            
            if firstAccount.type == .Mobility {
                onNavItemSelected(itemType: .Mobility(account: firstAccount))
            }
            else {
                onNavItemSelected(itemType: .HomeSolutions(account: firstAccount))
            }
        }
    }
    
    private func transitionFrom(controller old: UIViewController?, toController new: UIViewController) {
        
        // prepare old controller to be removed
        old?.willMove(toParentViewController: nil)
        
        // add new controller as child
        addChildViewController(new)
        
        // set up frame of new controller to begin to the right of the viewport
        new.view.frame = containerView.bounds
        containerView.addSubview(new.view)
        
        // remove old controller
        old?.view.removeFromSuperview()
        old?.removeFromParentViewController()
        
        // show new controller
        new.didMove(toParentViewController: self)
        
        // set current view controller
        currentlySelectedController = new
    }
    
    
    // MARK: UIGestureRecognizerDelegate methods
    
    internal func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        // if touch was received in overlay and burger is open we handle the touch
        return touch.view == overlay && isOpen == true
    }
}

