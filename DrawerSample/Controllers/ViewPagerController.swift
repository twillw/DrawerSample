
import UIKit

internal class ViewPagerController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    // MARK: instance variables
    
    private var pageViewController: UIPageViewController!
    private var pagedControllers = [UIViewController]()
    
    
    // MARK: outlets

    @IBOutlet weak var pagerMenu: UIStackView!
    @IBOutlet weak var pageViewContainer: UIView!
    
  
    // MARK: lifecycle methods
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up page view controller
        configurePageViewController()
    }


    // MARK: internal methods
    
    internal func initialize(withControllers controllers: [UIViewController]) {
        
        // add provided controllers to pagedControllers property
        pagedControllers.append(contentsOf: controllers)
    }
    
    
    // MARK: UIPageViewControllerDataSource
    
    internal func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // get current index of viewController
        guard let index = pagedControllers.index(of: viewController) else {
            return nil
        }
        
        // return controller at that index before the current index
        return controller(atIndex: index - 1)
    }
    
    internal func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = pagedControllers.index(of: viewController) else {
            return nil
        }
        
        // return controller at that index after the current index
        return controller(atIndex: index + 1)
    }
    
    
    // MARK: UIPageViewControllerDelegate
    
    internal func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        // animate page indicator to new title
    }
    
    internal func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        // TODO: not sure if this is needed
    }
    
    
    
    // MARK: private methods
    
    private func controller(atIndex index: Int) -> UIViewController? {
        
        // check if index is in array 
        if pagedControllers.count > index {
            return pagedControllers[index]
        }
        return nil
    }
    
    private func configurePageViewController() {
        
        // create page view controller
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal,
            options: nil)
        
        // set data source and delegate
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        // add it as a child
        addChildViewController(pageViewController)
        pageViewController.willMove(toParentViewController: self)
        
        // set page view controller's frame
        pageViewController.view.frame = pageViewContainer.frame
        
        // add page view controllers root view to pageViewContainer
        pageViewContainer.addSubview(pageViewController.view)
        
        // notify pager it's moved to parent
        pageViewController.didMove(toParentViewController: self)
    }

}

