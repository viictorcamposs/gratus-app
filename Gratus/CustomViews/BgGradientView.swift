import SwiftUI

struct BgGradientView: View {
    var body: some View {
        LinearGradient(colors: [.black, Color("DarkerGray")],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .ignoresSafeArea()
    }
}
