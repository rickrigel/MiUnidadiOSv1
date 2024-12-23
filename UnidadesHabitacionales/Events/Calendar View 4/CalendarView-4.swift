//
//  CalendarView-4.swift of CalendarView Demo
//
//  Created by Tomasz Kurylik
//    - Twitter: https://twitter.com/tkurylik
//    - Mail: tomasz.kurylik@mijick.com
//    - GitHub: https://github.com/FulcrumOne
//
//  Copyright ©2023 Mijick. Licensed under MIT License.


import SwiftUI
import MijickCalendarView
import MijickNavigationView

struct CalendarView4: NavigatableView {
    @State private var selectedDate: Date? = .now
    @State private var selectedMonth: Date = .now
    private let events: [Date: [Event]] = .init()
    var data: EventsModel
    var body: some View {
        VStack(spacing: 0) {
            createCalendarView()
            createEventsView()
            Spacer()
        }
    }
}
private extension CalendarView4 {
    func createCalendarView() -> some View {
        MCalendarView(selectedDate: $selectedDate, selectedRange: nil, configBuilder: configureCalendar)
            .padding(.horizontal, 24)
            .scrollDisabled(true)
            .fixedSize(horizontal: false, vertical: true)
    }
    func createEventsView() -> some View {
        EventsView(selectedDate: $selectedDate, events: getEvents(events: data))
            .padding(.horizontal, 20)
    }
}
private extension CalendarView4 {
    func configureCalendar(_ config: CalendarConfig) -> CalendarConfig {
        config
            .monthsTopPadding(36)
            .monthsBottomPadding(8)
            .daysHorizontalSpacing(1)
            .daysVerticalSpacing(3)
            .startMonth(selectedMonth)
            .endMonth(selectedMonth)
            .monthLabel(ML.Uppercased.init)
            .dayView(buildDayView)
    }
}
private extension CalendarView4 {
    func buildDayView(_ date: Date, _ isCurrentMonth: Bool, selectedDate: Binding<Date?>?, range: Binding<MDateRange?>?) -> DV.ColoredCircle {
        return .init(date: date, color: getDateColor(date), isCurrentMonth: isCurrentMonth, selectedDate: selectedDate, selectedRange: nil)
    }
    func getDateColor(_ date: Date) -> Color? {
       let hasSavedEvents = getEvents(events: data).first(where: { $0.key.isSame(date) }) != nil
        return hasSavedEvents ? .grayAccent : nil
    }
}

// MARK: Helpers
private extension CalendarView4 {
    func getEvents(events: EventsModel) ->[Date: [CalendarView4.Event]] {
        var eventsDictionary: [Date: [CalendarView4.Event]] = [:]
        // Define an array of possible colors
        let colors: [Color] = [.redAccent, .greenAccent, .orangeAccent]
        
        for data in events.event {
            // Pick a random color from the colors array
            let randomColor = colors.randomElement() ?? .redAccent
            let event = CalendarView4.Event(
                name: data.title,
                range: "\(data.startTime) - \(data.endTime)",
                area: data.area,
                color: randomColor
            )
            
            // Append the event to the array for the same date, or create a new array if the date isn't present
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            eventsDictionary[formatter.date(from: data.eventDate) ?? Date.now, default: []].append(event)
        }
        return eventsDictionary
    }
}

// MARK: - Preview
#Preview {
    CalendarView4( data: EventsModel(event: []))
}
