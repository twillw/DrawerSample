
import UIKit

@IBDesignable
internal class Button: UIButton {

    private var _style: String?
    
    @IBInspectable
    internal var style: String? {
        get {
            return _style
        }
        set (newValue) {
            
            _style = newValue
            if let val = newValue {
                
                Style.instance.apply(style: val, toView: self)
            }
        }
    }

}

