//
//  AddEventSwiftUIView.swift
//  UnidadesHabitacionales
//
//  Created by Ricardo Sanchez on 14/11/24.
//

import SwiftUI

struct AddEventSwiftUIView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel = EventsViewModel()
    @State var data: EventsModel?
    @State var eventName = ""
    @State var eventArea = ""
    @State var eventStartTime = Date.now
    @State var eventEndtime = Date.now
    @State var eventDate = Date.now
    var body: some View {
        VStack(spacing: 20) {
            TextField("Nombre del Evento", text: $eventName)
            TextField("Area del Evento", text: $eventArea)
            HStack {
                DatePicker("Hora de inicio", selection: $eventStartTime, displayedComponents: .hourAndMinute)
                DatePicker("Hora de fin", selection: $eventEndtime, displayedComponents: .hourAndMinute)
            }
            DatePicker("Día del evento", selection: $eventDate, displayedComponents: .date)
            Button(action: {
                viewModel.addEvent(title: eventName, area: eventArea, startTime: eventStartTime, endTime: eventEndtime, eventDay: eventDate, dataArray: data)
            }, label: {
                Text("Agregar Evento")
            })
            Spacer()
        }.padding(.all, 16)
            .onReceive(viewModel.$shouldDismiss, perform: { succes in
                if succes {
                    dismiss()
                }
            })
    }
}

#Preview {
    AddEventSwiftUIView()
}
