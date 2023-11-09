
enum Route:String, CaseIterable {
    case SHOP = "shop"
    case CART = "cart"
    case CHECK = "check"
    case MENU = "menu"
}


let bottomNavigationItems = [
    BottomNavigationItem(
        titleResource: "Shop",
        iconActive: "handbag.fill",
        iconInactive: "handbag",
        color: .blue,
        route: Route.SHOP.rawValue
    ),
    BottomNavigationItem(
        titleResource: "Cart",
        iconActive: "list.bullet",
        iconInactive: "list.bullet",
        color: .red,
        route: Route.CART.rawValue
    ),
    BottomNavigationItem(
        titleResource: "Check",
        iconActive: "map.fill",
        iconInactive: "map",
        color: .green,
        route: Route.CHECK.rawValue
    ),
    BottomNavigationItem(
        titleResource: "Menu",
        iconActive: "rectangle.grid.2x2.fill",
        iconInactive: "rectangle.grid.2x2",
        color: .indigo,
        route: Route.MENU.rawValue
    ),
]

