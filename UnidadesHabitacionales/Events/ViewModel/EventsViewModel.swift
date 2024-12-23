//
//  EventsViewModel.swift
//  UnidadesHabitacionales
//
//  Created by Ricardo Sanchez on 03/11/24.
//

import Foundation

class EventsViewModel: ObservableObject {
    @Published var eventsData: EventsModel?
    @Published var getEventSuccess: Bool = false
    @Published var shouldDismiss = false
    
    func getEvents() {
        FirestoreService().fetchDocument(from: "events", withID: "NdnbzDSgKUdKvbJs1KPd", as: EventsModel.self) { response in
            switch response {
            case .success(let data):
                self.eventsData = data
                self.getEventSuccess = true
            case .failure(let error):
                self.getEventSuccess = false
                print(error)
            }
        }
    }
    
    func addEvent(title: String, area: String, startTime: Date, endTime: Date, eventDay: Date, dataArray: EventsModel?) {
        var addData = dataArray ?? EventsModel(event: [])
        // format date to save as string
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "dd/MM/yyyy"
        let formatter2 = DateFormatter()
        formatter2.timeStyle = .short
        // Add or insert the new event
        let newEvent = EventModel(area: area, startTime: formatter2.string(from: startTime), endTime: formatter2.string(from: endTime), eventDate: formatter1.string(from: eventDay), title: title)
        if addData.event.isEmpty {
            addData.event.insert(newEvent, at: 0)
        }else {
            addData.event.append(newEvent)
        }
        FirestoreService().saveDataToFirestore(collection: "events", documentID: "NdnbzDSgKUdKvbJs1KPd", data: addData) { response in
            if response == nil {
                DispatchQueue.main.async {
                    self.shouldDismiss = true
                }
            }else {
                DispatchQueue.main.async {
                    self.shouldDismiss = false
                }
            }
        }
    }
}
