import SwiftUI

struct GratitudeListView: View {
    @EnvironmentObject var manager: DataManager
    
    var body: some View {
        NavigationView {
            ZStack {
                BgGradientView()
                
                if manager.gratitudes.isEmpty {
                    VStack {
                        Text("No gratitude entry was added yet.")
                            .font(.title)
                            .bold()
                        
                        Spacer()
                            .frame(height: 80)
                    }
                } else {
                    List(manager.gratitudes) { gratitude in
                        NavigationLink {
                            ZStack {
                                BgGradientView()
                                
                                ScrollView {
                                    VStack {
                                        Text(gratitude.message)
                                            .font(.title2)
                                            .bold()
                                        
                                        Spacer()
                                            .frame(height: 60)
                                        
                                        Text("\"\(gratitude.message)\"")
                                            .font(.system(size: 28, design: .serif))
                                            .italic()
                                            .multilineTextAlignment(.center)
                                            .frame(maxWidth: 300)
                                        
                                        Spacer()
                                    }
                                }
                            }
                        } label: {
                            VStack(alignment: .leading, spacing: 20) {
                                Text(gratitude.createdAt as! String)
                                    .font(.title)
                                    .bold()
                                
                                Text(gratitude.message)
                                    .foregroundStyle(.white)
                            }
                            .padding(.vertical)
                        }
                        .listRowSeparator(.hidden, edges: .all)
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("My list of gratitudes")
        }
        .tint(.white)
    }
}
#Preview {
    GratitudeListView()
        .environmentObject(DataManager())
        .preferredColorScheme(.dark)
}
