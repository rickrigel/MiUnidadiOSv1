//
//  HomeSwiftUIView.swift
//  UnidadesHabitacionales
//
//  Created by Ricardo Sanchez on 27/10/24.
//

import SwiftUI

struct HomeSwiftUIView: View {
    @ObservedObject var viewModel = HomeViewModel()
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text(viewModel.userData?.name ?? "")
                HStack {
                    Text(viewModel.userData?.unit ?? "")
                    Text(viewModel.userData?.apartment ?? "")
                }
                if viewModel.getStoreSuccess {
                    VStack(alignment: .leading) {
                        Text("Productos en venta")
                            .frame(alignment: .leading)
                    }.padding(.top, 20)
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(viewModel.storeData?.product ?? [], id: \.self) { item in
                                HomeStoreListSwiftUIView(title: item.title, price: item.price, imageUrl: item.image, detail: item.detail)
                            }
                            .listStyle(.plain)
                        }
                    }
                   
                }
                if viewModel.getEventSuccess {
                    VStack(alignment: .leading) {
                        Text("Comunicados")
                            .frame(alignment: .leading)
                    }.padding(.top, 20)
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(viewModel.eventsData?.event ?? [], id: \.self) { item in
                                HomeEventListSwiftUIView(title: item.title, area: item.area)
                            }
                            .listStyle(.plain)
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.all, 16)
            .onAppear {
                viewModel.getUserData()
                viewModel.getStore()
                viewModel.getEvents()
            }
        }
    }
}

#Preview {
    HomeSwiftUIView()
}
