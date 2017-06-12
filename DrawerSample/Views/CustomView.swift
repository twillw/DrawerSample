
import UIKit

internal class CustomView : UIView {
  
  // MARK: instance properties
  
  private var view: UIView!
  
  
  // MARK: constructors
  
  internal init(viewName: String, frame: CGRect) {
    
    // call super constructor
    super.init(frame: frame)
    
    // bind to nib
    bindNib(viewName: viewName)
  }
  
  internal init?(viewName: String, coder aDecoder: NSCoder) {
    
    // call super constructor
    super.init(coder: aDecoder)
    
    // bind to nib
    bindNib(viewName: viewName)
  }
  
  internal required init?(coder aDecoder: NSCoder) {
    
    // call super constructor
    super.init(coder: aDecoder)
    
    // fail
    fatalError(#function + " must be overridden");
  }
  
  
  // MARK: private methods
  
  private final func bindNib(viewName: String) {
    
    // load xib
    let nib = UINib(nibName: viewName, bundle: Bundle.main)
    view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    
    // initialize to fit container
    view.frame = bounds
    
    // add child
    addSubview(view)
    view.anchorToParent(parent: self)
    
    // invoke bind hook
    onBindView(view: view)
  }
  
  internal func onBindView(view: UIView) {
  }
}

extension UIView {
    
    internal func anchorToParent(parent: UIView) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["view": self]
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(
            contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        constraints.append(
            contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        parent.addConstraints(constraints)
        parent.updateConstraints()
    }
}
