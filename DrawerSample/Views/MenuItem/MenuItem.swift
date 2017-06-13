
internal enum MenuItemType {
    case Mobility(account: Account)
    case HomeSolutions(account: Account)
}

internal protocol MenuItem {
    var type: MenuItemType! { get }
}

