import SwiftUI

struct AddGratitudeView: View {
    @EnvironmentObject var manager: DataManager
    
    @State private var fullText = "What are you grateful for?"
    @Binding var isShowingGratitudeEntry: Bool
    
    let placeholder = "What are you grateful for?"
    
    var body: some View {
        ZStack {
            BgGradientView()
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        isShowingGratitudeEntry.toggle()
                    } label: {
                        Label("Dismiss screen cover", systemImage: "xmark")
                            .font(.title2)
                            .labelStyle(.iconOnly)
                            .foregroundStyle(.white)
                    }
                }
                
                HeadingView()
                
                GratitudeInputView(fullText: $fullText,
                                   placeholder: placeholder)
                
                Button {
                    if fullText != placeholder, fullText != "" {
                        let gratitude = Gratitude(message: fullText)
                        
                        manager.addGratitude(gratitude: gratitude)
                        
                        isShowingGratitudeEntry.toggle()
                    }
                } label: {
                    Label("Save", systemImage: "checkmark")
                        .font(.system(size: 20, weight: .bold))
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
                .tint(.white)
            }
            .padding(.horizontal, 20)
        }
    }
}

struct HeadingView: View {
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

struct GratitudeInputView: View {
    @Binding var fullText: String
    let placeholder: String
    
    
    var body: some View {
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
    AddGratitudeView(isShowingGratitudeEntry: .constant(false))
}
