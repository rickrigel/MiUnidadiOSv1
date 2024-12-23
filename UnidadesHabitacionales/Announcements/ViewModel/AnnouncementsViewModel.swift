//
//  AnnouncementsViewModel.swift
//  UnidadesHabitacionales
//
//  Created by Ricardo Sanchez on 03/11/24.
//

import Foundation

class AnnouncementsViewModel: ObservableObject {
    @Published var userData: UserModel?
    @Published var getUserSuccess: Bool = false
    @Published var announcementsData: AnnouncementsModel?
    @Published var getAnnouncementsSuccess: Bool = false
    @Published var shouldDismiss = false
    
    func getAnnouncements() {
        FirestoreService().fetchDocument(from: "comunication", withID: "8592a9HVkvW4M5d7lPMj", as: AnnouncementsModel.self) { response in
            switch response {
            case .success(let data):
                self.announcementsData = data
                self.getUserSuccess = true
            case .failure(_):
                self.getUserSuccess = false
            }
        }
    }
    
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
    
    func updateLikes(title: String, detail: String, like: Int, disLike: Int, index: Int, dataModel: AnnouncementsModel?) {
        var addData = dataModel ?? AnnouncementsModel(notice: [])
        let newData = AnnouncementModel(detail: detail, disLike: disLike, like: like, title: title)
        addData.notice.remove(at: index)
        addData.notice.insert(newData, at: index)
        FirestoreService().saveDataToFirestore(collection: "comunication", documentID: "8592a9HVkvW4M5d7lPMj", data: addData) { response in
            if response == nil {
                self.getAnnouncements()
            }else {
                
            }
        }
    }
    
    func addNotice(title: String, detail: String, dataModel: AnnouncementsModel?) {
        var addData = dataModel ?? AnnouncementsModel(notice: [])
        let newData = AnnouncementModel(detail: detail, disLike: 0, like: 0, title: title)
        if addData.notice.isEmpty {
            addData.notice.insert(newData, at: 0)
        }else {
            addData.notice.append(newData)
        }
        FirestoreService().saveDataToFirestore(collection: "comunication", documentID: "8592a9HVkvW4M5d7lPMj", data: addData) { response in
            if response == nil {
                self.shouldDismiss = true
            }else {
                self.shouldDismiss = false
            }
        }
    }
}
