
import UIKit

internal class MenuItem: CustomView {
    
    // MARK: Class Properties
    
    internal static let ViewName = "MenuItem"
    internal static let DefaultFrame = CGRect(x: 0, y: 0, width: 300, height: 60)
    
    
    // MARK: instance variables
    
    private var onItemSelected: ((Int) -> Void)?
    private var itemIndex: Int = 0
    
    
    // MARK: outlets
    
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var banLabel: UILabel!
    
    
    // MARK: Constructors
    
    internal init(withNickname nickname: String, andBan ban: String, itemIndex: Int, action onItemSelected: ((Int) -> Void)?) {
        
        // set instance variables
        self.onItemSelected = onItemSelected
        self.itemIndex = itemIndex
        
        super.init(viewName: MenuItem.ViewName, frame: MenuItem.DefaultFrame)
        
        // bind data to labels
        nicknameLabel.text = nickname
        banLabel.text = ban
    }
    
    // only called when build from interface builder
    internal required init?(coder aDecoder: NSCoder) {
        super.init(viewName: MenuItem.ViewName, coder: aDecoder)
    }
    
    // MARK: Internal Methods
    
    override func onBindView(view: UIView) {
    }
    
    
    // MARK: actions
    
    @IBAction func itemSelected(_ sender: Any) {
        onItemSelected?(itemIndex)
    }
}

