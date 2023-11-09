import SwiftUI
import UIKit

public struct BottomNavigation: View {
    let items: [BottomNavigationItem]
    @Binding var selected: Int
    let onClick: (String) -> Void

    public init(items: [BottomNavigationItem], selected: Binding<Int>, onClick: @escaping (String) -> Void) {
        self.items = items
        self._selected = selected
        self.onClick = onClick
    }

    public var body: some View {
        let view = BottomNavigationInternal(
            items: items,
            selected: _selected,
            onClick: onClick
        )
        view
            .layoutPriority(1)
            .frame(height: view.getTabHeight())
    }
}

public struct BottomNavigationInternal: UIViewRepresentable {
    let items: [BottomNavigationItem]
    @Binding var selected: Int
    let onClick: (String) -> Void

    @Remember private var tabControllerState = TabBarController()

    init(items: [BottomNavigationItem], selected: Binding<Int>, onClick: @escaping (String) -> Void) {
        self.items = items
        self._selected = selected
        self.onClick = onClick
    }

    func getTabHeight() -> CGFloat { tabControllerState.getTabHeight() }

    public func makeUIView(context _: Context) -> UIView {
        let tabController = tabControllerState
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
        tabControllerState.selectedIndex = selected
    }

    private func updateIcon() {
        let selectedPrevious = tabControllerState.selectedIndex
        if selectedPrevious != selected {
            let itemData = items[selectedPrevious]
            let tabBar = tabControllerState.tabBar.items![selectedPrevious]
            tabBar.image = UIImage(systemName: itemData.iconInactive)
        }
        let itemData = items[selected]
        let tabBar = tabControllerState.tabBar.items![selected]
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

    func getTabHeight() -> CGFloat { tabBar.frame.height }
}
