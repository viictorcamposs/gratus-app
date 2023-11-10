import SwiftUI

struct CurrentDayGratitudeView: View {
    
    @EnvironmentObject var manager: DataManager
    @StateObject private var viewModel = CurrentDayGratitudeViewModel()
    
    var body: some View {
        ZStack {
            BgGradientView()
            
            VStack {
                VStack(spacing: 20) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.weekDays) {
                            WeekDayView(viewModel: viewModel, weekDay: $0)
                        }
                    }
                    
                    Divider()
                        .background(Color.gray)
                }
                
                ScrollView {
                    HStack {
                        Text("Welcome, \(manager.username)")
                            .font(.system(size: 34, weight: .semibold))
                        
                        Spacer()
                    }
                    .padding()
                    .foregroundStyle(.white)
                    
                    Spacer()
                        .frame(height: 40)
                    
                    ScrollBodyView(viewModel: viewModel)
                }
                .foregroundStyle(.white)
                .fullScreenCover(isPresented: $viewModel.isShowingGratitudeEntry) {
                    AddGratitudeView(isShowingGratitudeEntry: $viewModel.isShowingGratitudeEntry)
                }
            }
        }
        .onAppear {
            viewModel.manager = manager
        }
    }
}

struct WeekDayView: View {
    
    @ObservedObject var viewModel: CurrentDayGratitudeViewModel
    let weekDay: WeekDay
    
    var body: some View {
        VStack(spacing: 10) {
            Text(weekDay.dayString)
                .font(.system(size: 12, weight: .semibold))
            
            Text(weekDay.dayNumber)
                .font(.system(size: 14, weight: .black))
        }
        .foregroundStyle(viewModel.selectedWeekDay == weekDay.date ? .white : .gray.opacity(0.5))
        .frame(width: 60, height: 60)
        .clipShape(.rect(cornerRadius: 8))
        .overlay {
            if viewModel.selectedWeekDay == weekDay.date {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray, lineWidth: 2)
                
            }
        }
        .onAppear {
            if weekDay.isCurrentDay, viewModel.selectedWeekDay.isEmpty {
                viewModel.selectedWeekDay = weekDay.date
            }
        }
        .onTapGesture {
            viewModel.selectedWeekDay = weekDay.date
        }
    }
}

struct ScrollBodyView: View {
    
    @ObservedObject var viewModel: CurrentDayGratitudeViewModel
    
    var body: some View {
        
        if let text = viewModel.selectedDayGratitudeEntry {
            VStack {
                Text("\"\(text)\"")
                    .font(.system(size: 28, design: .serif))
                    .italic()
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 300)
            }
            .padding()
        } else if viewModel.isSelectedWeekDayLaterToCurrentDate {
            SelectedDayWithoutEntryView(title: "Prepare yourself for the next day.",
                                        icon: "calendar.badge.clock")
        } else if viewModel.isSelectedWeekDayPreviousToCurrentDate {
            SelectedDayWithoutEntryView(title: "No gratitude added to this day.",
                                        icon: "calendar.badge.exclamationmark")
        } else {
            Text("Add your gratitude for the day")
                .font(.title3)
                .bold()
                .padding(.bottom, 30)
            
            Button {
                viewModel.isShowingGratitudeEntry = true
            } label: {
                Label("Add gratitude", systemImage: "plus")
                    .font(.system(size: 18, weight: .bold))
                    .labelStyle(.iconOnly)
                    .frame(width: 80, height: 32)
            }
            .buttonStyle(.borderedProminent)
            .tint(.gray)
        }
    }
}

struct SelectedDayWithoutEntryView: View {
    
    let title: String
    let icon: String
    
    var body: some View {
        Text(title)
            .font(.title3)
            .bold()
            .foregroundStyle(.gray)
            .padding(.bottom, 30)
        
        Image(systemName: icon)
            .symbolRenderingMode(.palette)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 90)
            .foregroundStyle(.gray, .gray.opacity(0.4))
    }
}

#Preview {
    CurrentDayGratitudeView()
        .environmentObject(DataManager())
}


