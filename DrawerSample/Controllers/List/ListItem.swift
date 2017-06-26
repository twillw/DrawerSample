

internal protocol ListItem {
    var cellIdentifier: String { get }
    func onItemSelected() -> Void
}

