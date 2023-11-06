import SwiftUI

struct CurrentDayGratitudeView: View {
    @EnvironmentObject var manager: GratusManager
    
    var viewModel = CurrentDayGratitudeViewModel()
    
    @State var isShowingGratitudeEntry: Bool = false
    
    var gratitudeList: [GratitudeEntry] = [
        GratitudeEntry(createdAt: Date(),
                       gratitude: "I'm grateful for having another opportunity to pursue excellence.")
    ]
    
    var body: some View {
        ZStack {
            BgGradientView()
            
            VStack {
                WeekNavigationView(viewModel: viewModel)
                
                ScrollView {
                    HStack {
                        Text("Welcome, \(manager.username ?? "Victor")")
                            .font(.system(size: 34, weight: .semibold))
                        
                        Spacer()
                    }
                    .padding()
                    .foregroundStyle(.white)
                    
                    Spacer()
                        .frame(height: 40)
                    
                    if gratitudeList.isEmpty {
                        AddGratitudeForTheDayView(isShowingGratitudeEntry: $isShowingGratitudeEntry)
                    } else {
                        VStack {
                            Text("\"\(gratitudeList[0].gratitude)\"")
                                .font(.system(size: 28, design: .serif))
                                .italic()
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: 300)
                        }
                        .padding()
                    }
                }
                .foregroundStyle(.white)
                .fullScreenCover(isPresented: $isShowingGratitudeEntry) {
                    GratitudeEntryView(isShowingGratitudeEntry: $isShowingGratitudeEntry,
                                       gratitudeEntryDate: Date())
                    .environmentObject(manager)
                }
            }
        }
    }
}

struct WeekDayView: View {
    let weekDay: WeekDay
    
    var body: some View {
        VStack(spacing: 10) {
            Text(weekDay.dayString)
                .font(.system(size: 12, weight: .semibold))
            
            Text(weekDay.dayNumber)
                .font(.system(size: 14, weight: .black))
        }
        .foregroundStyle(weekDay.isCurrentDay ? .white : .gray.opacity(0.5))
        .frame(width: 60, height: 60)
        .clipShape(.rect(cornerRadius: 8))
        .overlay {
            if weekDay.isCurrentDay == true {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray.opacity(0.5), lineWidth: 1)

            }
        }
    }
}

struct WeekNavigationView: View {
    let viewModel: CurrentDayGratitudeViewModel
    
    var body: some View {
        VStack(spacing: 20) {    
            HStack(spacing: 10) {
                ForEach(viewModel.weekDays) {
                    WeekDayView(weekDay: $0)
                }
            }
            
            Divider()
                .background(Color.gray)
        }
    }
}

#Preview {
    CurrentDayGratitudeView()
        .environmentObject(GratusManager())
}

struct AddGratitudeForTheDayView: View {
    @Binding var isShowingGratitudeEntry: Bool
    
    var body: some View {
        VStack {
            Text("Add your gratitude for the day")
                .font(.title3)
                .padding(.bottom, 20)
            
            Button {
                isShowingGratitudeEntry.toggle()
            } label: {
                Label("Add gratitude", systemImage: "plus.app.fill")
                    .font(.system(size: 34))
                    .labelStyle(.iconOnly)
                    .padding(10)
            }
        }
    }
}
