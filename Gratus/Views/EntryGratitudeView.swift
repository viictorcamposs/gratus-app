import SwiftUI

struct EntryGratitudeView: View {
    @State private var fullText = "What are you grateful for?"
    
    let placeholder = "What are you grateful for?"
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.black, Color("DarkerGray")],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack {
                HeadindView()
                
                TextEditor(text: $fullText)
                    .foregroundStyle(
                        fullText == placeholder ? .gray : .white
                    )
                    .transparentScrolling()
                    .onAppear {
                        NotificationCenter.default.addObserver(
                            forName: UIResponder.keyboardWillShowNotification,
                            object: nil,
                            queue: .main) { _ in
                                withAnimation {
                                    if self.fullText == placeholder {
                                        self.fullText = ""
                                    }
                                }
                        }
                        
                        NotificationCenter.default.addObserver(
                            forName: UIResponder.keyboardWillHideNotification,
                            object: nil,
                            queue: .main) { _ in
                                withAnimation {
                                    if self.fullText == "" {
                                        self.fullText = placeholder
                                    }
                                }
                            }
                    }
            }
            .padding(.horizontal, 20)
        }
    }
}

struct HeadindView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Today")
                        .font(.system(size: 38, weight: .medium, design: .serif))
                    Text("I am grateful for")
                        .font(.system(size: 34, weight: .medium, design: .serif))
                }
                .padding(.vertical, 16)
                .foregroundStyle(.white)
                
                Spacer()
            }
            
            Divider()
                .background(.gray)
        }
    }
}

public extension View {
    func transparentScrolling() -> some View {
        if #available(iOS 16.0, *) {
            return scrollContentBackground(.hidden)
        } else {
            return onAppear {
                UITextView.appearance().backgroundColor = .clear
            }
        }
    }
}

#Preview {
    EntryGratitudeView()
}
