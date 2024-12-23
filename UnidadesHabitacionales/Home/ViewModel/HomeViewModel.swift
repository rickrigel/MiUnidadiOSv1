//
//  HomeViewModel.swift
//  UnidadesHabitacionales
//
//  Created by Ricardo Sanchez on 03/11/24.
//

import Foundation
import SwiftUI
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    @Published var userData: UserModel?
    @Published var getUserSuccess: Bool = false
    @Published var storeData: ProductsModel?
    @Published var getStoreSuccess: Bool = false
    @Published var eventsData: EventsModel?
    @Published var getEventSuccess: Bool = false
    
    func getUserData() {
        let user = UserDefaults.standard.string(forKey: "email") ?? ""
        FirestoreService().fetchDocument(from: "users", withID: user, as: UserModel.self) { response in
            switch response {
            case .success(let data):
                self.userData = data
                self.getUserSuccess = true
            case .failure(_):
                self.getUserSuccess = false
            }
        }
    }
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
    func getStore() {
        FirestoreService().fetchDocument(from: "products", withID: "8592a9HVkvW4M5d7lPMj", as: ProductsModel.self) { response in
            switch response {
            case .success(let data):
                self.storeData = data
                self.getStoreSuccess = true
            case .failure(let error):
                self.getStoreSuccess = false
                print(error)
            }
        }
    }
}
