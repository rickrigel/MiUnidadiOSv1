//
//  AddAnnaunceSwiftUIView.swift
//  UnidadesHabitacionales
//
//  Created by Ricardo Sanchez on 14/11/24.
//

import SwiftUI

struct AddAnnaunceSwiftUIView: View {
    @ObservedObject var viewModel = AnnouncementsViewModel()
    @State var title = ""
    @State var description = ""
    @State var dataModel: AnnouncementsModel?
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(spacing: 10) {
            TextField("Título", text: $title)
            TextField("Descripción", text: $description)
            Button(action: {
                viewModel.addNotice(title: title, detail: description, dataModel: dataModel)
            }, label: {
                Text("Agregar Encuesta")
            })
        }
        .padding(.all, 16)
        .onReceive(viewModel.$shouldDismiss, perform: { succes in
            if succes {
                dismiss()
            }
        })
    }
}

#Preview {
    AddAnnaunceSwiftUIView()
}
