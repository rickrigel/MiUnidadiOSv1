//
//  AnnouncementsModel.swift
//  UnidadesHabitacionales
//
//  Created by Ricardo Sanchez on 03/11/24.
//

import Foundation

struct AnnouncementsModel: Codable, Equatable {
    var notice: [AnnouncementModel]
}

struct AnnouncementModel: Codable, Identifiable, Hashable {
    var id = UUID()
    var detail: String
    var disLike: Int
    var like: Int
    var title: String
    // Coding keys to map fields from Firestore
    enum CodingKeys: String, CodingKey {
       case detail, disLike, like, title
    }
}
