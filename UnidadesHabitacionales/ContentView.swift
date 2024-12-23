//
//  ContentView.swift
//  UnidadesHabitacionales
//
//  Created by Ricardo Sanchez on 27/10/24.
//

import SwiftUI

struct ContentView: View {
    @State var destination = false
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Cargando...")
        }
        .padding()
        .navigationDestination(isPresented: $destination) {
            if UserDefaults.standard.bool(forKey: "isLoggedIn") {
                NavigationSwifUIView()
            } else {
                LoginSwiftUIView()
            }
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.destination = true
            }
        }
    }
}

#Preview {
    ContentView()
}
