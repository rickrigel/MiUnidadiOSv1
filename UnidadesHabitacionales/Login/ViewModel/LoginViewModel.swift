//
//  LoginViewModel.swift
//  UnidadesHabitacionales
//
//  Created by Ricardo Sanchez on 27/10/24.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    let dataManager = FirestoreService()
    @Published var loginStatus: Bool = false
    let defaults = UserDefaults.standard
    func login(user: String, pass: String) {
        let userData = UserModel(name: "Ricardo Rigel", apartment: "", unit: "", isAdmin: true)
        FirebaseAuthManager.shared.logIn(email: user, password: pass, completion: {result in
            switch result {
            case .success(_):
                self.dataManager.saveDataToFirestore(collection: "users", documentID: user, data: userData, completion: {error in
                    if let error = error {
                        self.loginStatus = false
                        print("Error saving data: \(error.localizedDescription)")
                    } else {
                        self.defaults.setValue(user, forKey: "email")
                        self.defaults.setValue(true, forKey: "isLoggedIn")
                        self.loginStatus = true
                    }
                })
            case .failure(_):
                break
            }
        })
    }
    
}
