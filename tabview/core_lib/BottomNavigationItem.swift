import SwiftUI

public struct BottomNavigationItem {
    public let titleResource: String
    public let iconActive: String
    public let iconInactive: String
    public let color: Color
    public let route: String

    public init(titleResource: String, iconActive: String, iconInactive: String, color: Color, route: String) {
        self.titleResource = titleResource
        self.iconActive = iconActive
        self.iconInactive = iconInactive
        self.color = color
        self.route = route
    }
}
