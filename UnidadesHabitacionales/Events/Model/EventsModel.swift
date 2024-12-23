//
//  EventsModel.swift
//  UnidadesHabitacionales
//
//  Created by Ricardo Sanchez on 03/11/24.
//

import Foundation
import FirebaseCore

struct EventsModel: Codable, Equatable {
    var event: [EventModel]
}

struct EventModel: Codable, Identifiable, Hashable {
    var id = UUID()
    var area: String
    var startTime: String
    var endTime: String
    var eventDate: String
    var title: String
    // Coding keys to map fields from Firestore
    enum CodingKeys: String, CodingKey {
        case area, startTime, endTime, eventDate, title
    }
}
