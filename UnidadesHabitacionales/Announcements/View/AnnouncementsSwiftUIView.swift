//
//  AnnouncementsSwiftUIView.swift
//  UnidadesHabitacionales
//
//  Created by Ricardo Sanchez on 03/11/24.
//

import SwiftUI

struct AnnouncementsSwiftUIView: View {
    @ObservedObject var viewModel = AnnouncementsViewModel()
    @State var triggerDestination: Bool = false
    var body: some View {
        VStack {
            //if viewModel.getUserSuccess && viewModel.userData?.isAdmin == false {
                Button {
                    triggerDestination = true
                } label: {
                    Text("Agregar Encuesta")
                }

            //}
            ScrollView {
                VStack {
                    LazyVStack {
                        let data = viewModel.announcementsData?.notice ?? []
                        ForEach(Array(((data.enumerated()))), id: \.element) { index, item in
                            AnnouncementsListSwiftUIView(title: item.title, description: item.detail, like: item.like, disLike: item.disLike) { like in
                                viewModel.updateLikes(title: item.title, detail: item.detail, like: like, disLike: item.disLike, index: index, dataModel: viewModel.announcementsData)
                            } onDislikeTapped: { disLike in
                                viewModel.updateLikes(title: item.title, detail: item.detail, like: item.disLike, disLike: disLike, index: index, dataModel: viewModel.announcementsData)
                            }
                        }
                        .listStyle(.plain)
                    }
                }
            }
        }
        .padding(.all, 16)
        .onAppear {
            viewModel.getUserData()
            viewModel.getAnnouncements()
        }
        .navigationDestination(isPresented: $triggerDestination) {
            AddAnnaunceSwiftUIView(dataModel: viewModel.announcementsData)
        }
    }
}

#Preview {
    AnnouncementsSwiftUIView()
}
