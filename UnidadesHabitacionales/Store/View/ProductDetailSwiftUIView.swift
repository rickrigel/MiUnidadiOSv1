//
//  ProductDetailSwiftUIView.swift
//  UnidadesHabitacionales
//
//  Created by Ricardo Sanchez on 03/11/24.
//

import SwiftUI

struct ProductDetailSwiftUIView: View {
    @State var title: String
    @State var price: Int
    @State var imageUrl: String
    @State var detail: String
    var body: some View {
        VStack(spacing: 16) {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Image(systemName: "photo.fill")
            }
            .frame(width: 300, height: 250)
            .padding(.bottom, 20)
            Text(title)
            Text(detail)
            Text("$\(String(price))")
            Spacer()
        }.padding(.all, 16)
    }
}

#Preview {
    ProductDetailSwiftUIView(title: "", price: 0, imageUrl: "", detail: "")
}
