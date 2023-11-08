import SwiftUI

struct CurrentDayGratitudeView: View {
    
    @EnvironmentObject var manager: GratusManager
    @StateObject var viewModel = CurrentDayGratitudeViewModel()
    
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
                    .stroke(.gray.opacity(0.5), lineWidth: 1)
                
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
    
    @EnvironmentObject var manager: GratusManager
    @ObservedObject var viewModel: CurrentDayGratitudeViewModel
    
    var body: some View {
        if viewModel.isSelectedWeekDayLaterToCurrentDate {
            Text("Prepare yourself for the next day.")
                .font(.title3)
        } else if viewModel.isSelectedWeekDayPreviousToCurrentDate {
            if let gratitude = viewModel.getSelectedDayGratitudeEntry(manager: manager) {
                GratitudeTextView(text: gratitude)
            } else {
                Text("No gratitude added to this day.")
                    .font(.title3)
            }
        } else {
            if let gratitude = viewModel.getSelectedDayGratitudeEntry(manager: manager) {
                GratitudeTextView(text: gratitude)
            } else {
                VStack {
                    Text("Add your gratitude for the day")
                        .font(.title3)
                        .padding(.bottom, 20)
                    
                    Button {
                        viewModel.isShowingGratitudeEntry = true
                    } label: {
                        Label("Add gratitude", systemImage: "plus.app.fill")
                            .font(.system(size: 34))
                            .labelStyle(.iconOnly)
                            .padding(10)
                    }
                }
            }
        }
    }
}

struct GratitudeTextView: View {
    var text: String
    
    var body: some View {
        VStack {
            Text("\"\(text)\"")
                .font(.system(size: 28, design: .serif))
                .italic()
                .multilineTextAlignment(.center)
                .frame(maxWidth: 300)
        }
        .padding()
    }
}

#Preview {
    CurrentDayGratitudeView()
        .environmentObject(GratusManager())
}


