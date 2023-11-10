import SwiftUI

struct GAButton: View {
    
    let title: String
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Label(title, systemImage: icon)
                .font(.system(size: 18, weight: .bold))
                .labelStyle(.iconOnly)
                .frame(width: 80, height: 32)
        }
        .buttonStyle(.borderedProminent)
        .tint(.gray)
    }
}
