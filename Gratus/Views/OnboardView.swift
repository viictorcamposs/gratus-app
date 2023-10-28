import SwiftUI

struct OnboardView: View {
    @State private var username = String()
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            withAnimation(.default) {
                VStack {
                    Text("Hey there! Welcome to gratus.")
                        .font(.title2)
                        .padding(.bottom)
                    
                    Text("What's your name?")
                        .font(.title3)
                        .bold()
                        
                    
                    VStack(spacing: 0) {
                        TextField(
                            "",
                            text: $username,
                            prompt: Text("My name is")
                                .foregroundColor(.gray)
                        )
                            .autocorrectionDisabled()
                            .frame(maxWidth: 300)
                            .frame(height: 48)
                        
                        Divider()
                            .background(Color.white)
                            .frame(maxWidth: 320)
                    }
                    .scenePadding(.vertical)
                    
                    Button {
                        
                    } label: {
                        Text("Enter")
                            .frame(width: 100, height: 48)
                            .background(.gray)
                            .foregroundStyle(.white)
                            .cornerRadius(8)
                            .bold()
                    }
                    .scenePadding(.top)
                }
            }
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    OnboardView()
}
