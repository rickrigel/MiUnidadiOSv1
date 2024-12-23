//
//  StoreSwiftUIView.swift
//  UnidadesHabitacionales
//
//  Created by Ricardo Sanchez on 03/11/24.
//

import SwiftUI

struct StoreSwiftUIView: View {
    @ObservedObject var viewModel = StoreViewModel()
    @State var triggerDestination: Bool = false
    var body: some View {
        VStack {
            Button {
                triggerDestination = true
            } label: {
                Text("Agregar Producto")
            }

            ScrollView {
                VStack {
                    LazyVStack {
                        ForEach(viewModel.storeData?.product ?? [], id: \.self) { item in
                            HomeStoreListSwiftUIView(title: item.title, price: item.price, imageUrl: item.image, detail: item.detail)
                        }
                        .listStyle(.plain)
                    }
                }
            }
        }
        .padding(.all, 16)
        .onAppear {
            viewModel.getStore()
        }
        .navigationDestination(isPresented: $triggerDestination) {
            ProductUploadSwiftUIView(storeData: viewModel.storeData)
        }
    }
}

#Preview {
    StoreSwiftUIView()
}
