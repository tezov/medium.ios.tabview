import SwiftUI
import UIKit

public struct BottomNavigation: View {
    @Remember private var tabController = TabBarController()
    let items: [BottomNavigationItem]
    @Binding var selected: Int
    let onClick: (String) -> Void
    
    public init(items: [BottomNavigationItem], selected: Binding<Int>, onClick: @escaping (String) -> Void) {
        self.items = items
        self._selected = selected
        self.onClick = onClick
    }

    public var body: some View {
        BottomNavigationInternal(
            items: items,
            selected: _selected,
            onClick: onClick,
            tabController: tabController
        ).frame(height: tabController.getTabHeight())
    }
}

public struct BottomNavigationInternal: UIViewRepresentable {
    let items: [BottomNavigationItem]
    @Binding var selected: Int
    let onClick: (String) -> Void
    fileprivate weak var tabController: TabBarController?
    
    fileprivate init(
        items: [BottomNavigationItem],
        selected: Binding<Int>,
        onClick: @escaping (String) -> Void,
        tabController: TabBarController
    ) {
        self.items = items
        self._selected = selected
        self.onClick = onClick
        self.tabController = tabController
    }

    func getTabHeight() -> CGFloat { tabController!.getTabHeight() }

    public func makeUIView(context _: Context) -> UIView {
        let tabController = tabController!
        tabController.tabBar.backgroundColor = .systemBackground
        tabController.setViewControllers(items.map { _ in UIViewController() }, animated: false)
        for i in 0 ..< items.count {
            let itemData = items[i]
            let tabBar = tabController.tabBar.items![i]
            tabBar.title = itemData.titleResource
            tabBar.image = UIImage(systemName: itemData.iconInactive)
        }
        tabController.onClick = { onClick(items[$0].route) }
        return tabController.view
    }

    public func updateUIView(_: UIView, context _: Context) {
        updateIcon()
        tabController!.selectedIndex = selected
    }

    private func updateIcon() {
        let selectedPrevious = tabController!.selectedIndex
        if selectedPrevious != selected {
            let itemData = items[selectedPrevious]
            let tabBar = tabController!.tabBar.items![selectedPrevious]
            tabBar.image = UIImage(systemName: itemData.iconInactive)
        }
        let itemData = items[selected]
        let tabBar = tabController!.tabBar.items![selected]
        tabBar.image = UIImage(systemName: itemData.iconActive)
    }
}

private class TabBarController: UITabBarController, UITabBarControllerDelegate {
    var onClick: ((_ index: Int) -> Void)? = nil

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        delegate = self
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) { fatalError("init?(coder: NSCoder) not implemented") }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let index = tabBarController.viewControllers?.firstIndex(of: viewController) {
            onClick?(index)
        }
        return false
    }

    public func getTabHeight() -> CGFloat { tabBar.frame.height }
}
