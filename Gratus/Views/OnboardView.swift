import SwiftUI

struct OnboardView: View {
    @State private var username = String()
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.black, Color("DarkerGray")],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            
            VStack {
                Text("Hey there! Welcome to gratus.")
                    .font(.system(size: 24))
                    .padding(.bottom)
                    .foregroundStyle(.white)
                
                Text("What's your first name?")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                
                
                UsernameInput(username: $username)
                
                Button {
                    if username == "" {
                        print("For better experience you must provide your first name")
                    } else {
                        print("Hello, \(username). Welcome to gratus! May this be the beginning of a life full of improvements and achievements.")
                    }
                } label: {
                    GAButton(title: "Enter",
                             bgColor: .gray,
                             textColor: .white)
                }
                .scenePadding(.top)
            }
        }
    }
    
    func addUsernameToUserDefaults() {
        
    }
}

#Preview {
    OnboardView()
}

struct UsernameInput: View {
    @Binding var username: String
    
    var body: some View {
        VStack(spacing: 0) {
            TextField(
                "",
                text: $username,
                prompt: Text("My name is")
                    .foregroundColor(.gray)
            )
            .foregroundStyle(.white)
            .autocorrectionDisabled()
            .frame(width: 300, height: 50)
            
            Divider()
                .background(Color.white)
                .frame(maxWidth: 320)
        }
        .scenePadding(.vertical)
    }
}
