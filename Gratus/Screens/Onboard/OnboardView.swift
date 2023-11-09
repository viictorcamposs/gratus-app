import SwiftUI

struct OnboardView: View {
    
    @EnvironmentObject var manager: DataManager
    @StateObject var viewModel = OnboardViewModel()
    
    var body: some View {
        ZStack {
            BgGradientView()
            
            VStack {
                Text("Hey there! Welcome to gratus.")
                    .font(.system(size: 24))
                    .padding(.bottom)
                    .foregroundStyle(.white)
                
                Text("What's your first name?")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                
                
                UsernameInput(username: $viewModel.username)
                
                Button {
                    viewModel.completeOnboarding(update: manager)
                } label: {
                    Label("Enter", systemImage: "arrow.right")
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
                .tint(.white)
            }
            .alert(viewModel.alertTitle, isPresented: $viewModel.didFail) {
                Button("Ok") {
                    viewModel.didFail = false
                }
            } message: {
                Text(viewModel.alertMessage)
            }

        }
    }
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
        .padding(.vertical, 50)
    }
}

#Preview {
    OnboardView()
        .environmentObject(DataManager())
}
