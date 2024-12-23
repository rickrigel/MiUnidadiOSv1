//
//  EventsModel.swift
//  UnidadesHabitacionales
//
//  Created by Ricardo Sanchez on 03/11/24.
//

import Foundation
import FirebaseFirestore

struct ProductsModel: Codable, Equatable {
    var product: [ProductModel]
}

struct ProductModel: Codable, Identifiable, Hashable {
    var id = UUID()  // UUID generated locally
    var title: String
    var detail: String
    var image: String
    var price: Int
    
    // Coding keys to map fields from Firestore
    enum CodingKeys: String, CodingKey {
        case title, detail, image, price
    }
}
