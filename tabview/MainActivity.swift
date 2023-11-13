import SwiftUI

struct MainActivity: View {
    @State var selected:Int = 0
    
    var body: some View {

        withBottomNavigationBar(
            items: bottomNavigationItems,
            selected: $selected,
            onClick: { route in
                if let index = (Route.allCases.firstIndex {
                    $0.rawValue == route
                }) {
                    selected = index
                }
            }) {
                
                ZStack {
                    bottomNavigationItems[selected].color.ignoresSafeArea()
                    Text("route is : \(bottomNavigationItems[selected].route)")
                }

            }

    }
}

struct withBottomNavigationBar<Content: View>: View {
    let items:[BottomNavigationItem]
    @Binding var selected:Int
    let onClick: (String) -> Void
    @ViewBuilder var content: Content
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                content
                    .frame(maxWidth: .infinity, maxHeight:.infinity)
                BottomNavigation(
                    items : items,
                    selected: _selected,
                    onClick: onClick
                )
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

#Preview {
    MainActivity()
}
