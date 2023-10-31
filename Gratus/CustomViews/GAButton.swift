import SwiftUI

struct GAButton: View {
    var title: String
    var bgColor: Color
    var textColor: Color
    
    var body: some View {
        Text(title)
            .font(.system(size: 20, weight: .bold))
            .frame(width: 200, height: 50)
            .background(bgColor)
            .foregroundStyle(textColor)
            .clipShape(.rect(cornerRadius: 8))
    }
}
