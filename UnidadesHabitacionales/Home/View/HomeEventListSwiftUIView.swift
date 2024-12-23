//
//  HomeEventListSwiftUIView.swift
//  UnidadesHabitacionales
//
//  Created by Ricardo Sanchez on 03/11/24.
//

import SwiftUI

struct HomeEventListSwiftUIView: View {
    @State var title: String
    @State var area: String
    var body: some View {
        HStack {
            Image(systemName: "calendar.badge.clock")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
            VStack(alignment: .leading) {
                Text(title)
                Text(area)
            }
        }
        .padding(.all, 20)
        .background(Color(Color.white))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 1)
        )
    }
}

#Preview {
    HomeEventListSwiftUIView(title: "", area: "")
}
