//
//  LoginSwiftUIView.swift
//  UnidadesHabitacionales
//
//  Created by Ricardo Sanchez on 27/10/24.
//

import SwiftUI

struct LoginSwiftUIView: View {
    @State var userTextField = ""
    @State var passTextField = ""
    @ObservedObject var viewModel = LoginViewModel()
    var body: some View {
        VStack {
            TextField("Correo", text: $userTextField)
            TextField("Contraseña", text: $passTextField)
                .padding(.top, 20)
            Button {
                viewModel.login(user: userTextField, pass: passTextField)
            } label: {
                Text("Iniciar Sesión")
            }
            .padding(.top, 20)
        }
        .padding(.all, 16)
        .navigationDestination(isPresented: $viewModel.loginStatus) {
            NavigationSwifUIView()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    LoginSwiftUIView()
}
