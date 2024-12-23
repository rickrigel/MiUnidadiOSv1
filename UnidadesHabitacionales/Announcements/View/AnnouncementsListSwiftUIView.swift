//
//  AnnouncementsListSwiftUIView.swift
//  UnidadesHabitacionales
//
//  Created by Ricardo Sanchez on 03/11/24.
//

import SwiftUI

struct AnnouncementsListSwiftUIView: View {
    @ObservedObject var viewModel = AnnouncementsViewModel()
    @State var title: String
    @State var description: String
    @State var like: Int
    @State var disLike: Int
    var onLikeTapped: (Int) -> Void
    var onDislikeTapped: (Int) -> Void
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
            Text(description)
            HStack(spacing: 20) {
                Button {
                    like += 1
                    onLikeTapped(like)
                } label: {
                    HStack {
                        Image(systemName: "hand.thumbsup.fill")
                        Text(String(like))
                    }
                }
                Button {
                    disLike += 1
                    onDislikeTapped(disLike)
                } label: {
                    HStack {
                        Image(systemName: "hand.thumbsdown.fill")
                        Text(String(disLike))
                    }
                }
                Spacer()

            }
            Spacer()
        }
    }
}

#Preview {
    AnnouncementsListSwiftUIView(title: "", description: "", like: 0, disLike: 0) {_ in
        
    } onDislikeTapped: {_ in}
}
