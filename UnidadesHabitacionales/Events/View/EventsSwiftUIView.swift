//
//  EventsSwiftUIView.swift
//  UnidadesHabitacionales
//
//  Created by Ricardo Sanchez on 03/11/24.
//

import SwiftUI
import MijickCalendarView

struct EventsSwiftUIView: View {
    @ObservedObject var viewModel = EventsViewModel()
    @State private var selectedDate: Date? = nil
    @State private var selectedRange: MDateRange? = .init()
    @State private var presentView: Bool = false
    var body: some View {
        VStack(spacing: 10) {
            Button(action: {
                presentView = true
            }, label: {
                Text("Agregar Evento")
            })
            CalendarView4(data: viewModel.eventsData ?? EventsModel(event: []))
        }
        .padding(.all, 19)
        .onAppear {
            viewModel.getEvents()
        }
        .navigationDestination(isPresented: $presentView) {
            AddEventSwiftUIView(data: viewModel.eventsData)
        }
    }
}

#Preview {
    EventsSwiftUIView()
}
