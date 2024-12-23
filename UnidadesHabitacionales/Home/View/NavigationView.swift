//
//  NavigationView.swift
//  UnidadesHabitacionales
//
//  Created by Ricardo Sanchez on 27/10/24.
//

import Foundation
import SwiftUI

struct NavigationSwifUIView: View {
    var body: some View {
        TabView {
            HomeSwiftUIView()
                .tabItem {
                    Label("Inicio", systemImage: "house")
                }
            StoreSwiftUIView()
                .tabItem {
                    Label("Tienda", systemImage: "storefront.fill")
                }
            AnnouncementsSwiftUIView()
                .tabItem {
                    Label("Encuestas", systemImage: "book.fill")
                }
            EventsSwiftUIView()
                .tabItem {
                    Label("Eventos", systemImage: "calendar")
                }

        }
        .navigationBarBackButtonHidden()
    }
}
