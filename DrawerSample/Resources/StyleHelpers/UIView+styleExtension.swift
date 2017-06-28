
import UIKit

private var styleKey: UInt8 = 0 // We still need this boilerplate

internal extension UIView {
    
    @IBInspectable
    internal var style: String? {
        get {
            return objc_getAssociatedObject(self, &styleKey) as! String?
        }
        set (newValue) {
            objc_setAssociatedObject(self, &styleKey, newValue,
                objc_AssociationPolicy(rawValue: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN.rawValue )!)
            
            if let val = newValue {
                
                Style.instance.apply(style: val, toView: self)
            }
        }
    }
}

