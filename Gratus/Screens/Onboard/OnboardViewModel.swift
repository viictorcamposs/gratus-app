import SwiftUI

class OnboardViewModel: ObservableObject {
    
    @Published var username = String()
    @Published var didFail = false
    
    let alertTitle = "Incomplete Profile"
    let alertMessage = "Oops! It seems you haven't entered your first name. To personalize your experience, please provide your first name."
    
    func completeOnboarding(update manager: GratusManager) {
        if username.isEmpty {
            didFail = true
        } else {
            DispatchQueue.main.async {
                manager.saveUsername(self.username)
            }
        }
    }
}
 
