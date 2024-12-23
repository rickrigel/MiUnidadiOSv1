//
//  HomeStoreListSwiftUIView.swift
//  UnidadesHabitacionales
//
//  Created by Ricardo Sanchez on 03/11/24.
//

import SwiftUI

struct HomeStoreListSwiftUIView: View {
    @State var title: String
    @State var price: Int
    @State var imageUrl: String
    @State var detail: String
    @State var triggerDestination: Bool = false
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Image(systemName: "photo.fill")
            }
            .frame(width: 100, height: 100)
            .border(Color.gray)
            VStack(alignment: .leading) {
                Text(title)
                Text("$\(String(price))")
            }
        }
        .frame(width: 230, height: 120, alignment: .leading)
        .onTapGesture {
            triggerDestination = true
        }
        .padding(.all, 20)
        .background(Color(Color.white))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 1)
        )
        .navigationDestination(isPresented: $triggerDestination) {
            ProductDetailSwiftUIView(title: title, price: price, imageUrl: imageUrl, detail: detail)
        }
    }
}

#Preview {
    HomeStoreListSwiftUIView(title: "", price: 0, imageUrl: "", detail: "")
}
