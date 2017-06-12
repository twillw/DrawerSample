
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
    private var accountControllers = [AccountController]()
    private var currentlySelectedIndex = 0
    
    
    // MARK: lifecycle methods
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize drawer menu
        initializeDrawer()
        
        // add child view controllers
        // TODO: this is just for testing
        let test1 = UIStoryboard(name: "Test", bundle: nil).instantiateInitialViewController() as! TestController
        test1.labelText = "Test 1"
        test1.title = "Test 1"
        let test2 = UIStoryboard(name: "Test", bundle: nil).instantiateInitialViewController() as! TestController
        test2.labelText = "Test 2"
        test2.title = "Test 2"
        let test3 = UIStoryboard(name: "Test", bundle: nil).instantiateInitialViewController() as! TestController
        test3.labelText = "Test 3"
        test3.title = "Test 3"
        let account1 = AccountController(controllers: [test1, test2, test3])
        account1.account = Account(ban: "123456", name: "First Jimmy")
        
        
        let test4 = UIStoryboard(name: "Test", bundle: nil).instantiateInitialViewController() as! TestController
        test4.labelText = "Test 4"
        test4.title = "Test 4"
        let test5 = UIStoryboard(name: "Test", bundle: nil).instantiateInitialViewController() as! TestController
        test5.labelText = "Test 5"
        test5.title = "Test 5"
        let account2 = AccountController(controllers: [test4, test5])
        account2.account = Account(ban: "67890", name: "Second Jimmy")
        
        
        addAccountController(controller: account1)
        addAccountController(controller: account2)
        
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
    
    // TODO: should be able to use this for an array as well
    private func addAccountController(controller: AccountController) {
        
        // get current index based on array length
        let newIndex = accountControllers.count
        
        // add account controller to list
        accountControllers.append(controller)
        
        // add link to controller in nav menu
        drawerMenu.addMenuItem(controller.account, atIndex: newIndex, onSelection: onNavItemSelected)
    }
    
    private func onNavItemSelected(selectedItem: Int) {
        
        // if new index doesn't match currently selected index then transition to new controller
        if selectedItem != currentlySelectedIndex {
            
            transitionFrom(controller: accountControllers[currentlySelectedIndex],
                toController: accountControllers[selectedItem])
            currentlySelectedIndex = selectedItem
        }
        
        // close burger menu
        closeDrawer()
    }
    
    private func setDefaultController() {
        
        // if accountControllers is not empty get the first
        if let firstController = accountControllers.first {
            
            // add first controller as a child
            addChildViewController(firstController)
            
            // set up new controllers frame
            // TODO: anchor new view with constraints
            firstController.view.frame = containerView.bounds
            containerView.addSubview(firstController.view)
            
            // notify controller
            firstController.didMove(toParentViewController: self)
        }
    }
    
    private func transitionFrom(controller old: AccountController, toController new: AccountController) {
        
        // prepare old controller to be removed
        old.willMove(toParentViewController: nil)
        
        // add new controller as child
        addChildViewController(new)
        
        // set up frame of new controller to begin to the right of the viewport
        new.view.frame = containerView.bounds
        containerView.addSubview(new.view)
        
        // remove old controller
        old.view.removeFromSuperview()
        old.removeFromParentViewController()
        
        // show new controller
        new.didMove(toParentViewController: self)
    }
    
    
    // MARK: UIGestureRecognizerDelegate methods
    
    internal func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        // if touch was received in overlay and burger is open we handle the touch
        return touch.view == overlay && isOpen == true
    }
}

