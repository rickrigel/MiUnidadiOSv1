//
//  ProductUploadSwiftUIView.swift
//  UnidadesHabitacionales
//
//  Created by Ricardo Sanchez on 03/11/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct ProductUploadSwiftUIView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel = StoreViewModel()
    @State private var isDocumentPickerPresented = false
    @State private var selectedFileURLs: [URL] = []
    @State var title: String = ""
    @State var detail: String = ""
    @State var price: String = ""
    @State var imageData: Image?
    let storeData: ProductsModel?
    var body: some View {
        VStack(spacing: 10) {
            Button {
                isDocumentPickerPresented.toggle()
            } label: {
                Text("Agregar Imagen")
            }
            .padding()
            .sheet(isPresented: $isDocumentPickerPresented) {
                DocumentPicker(supportedTypes: [.image]) { urls in
                    selectedFileURLs = urls
                }
            }
            AsyncImage(url: selectedFileURLs.first) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .onAppear {
                        imageData = image
                    }
            } placeholder: {
                Image(systemName: "photo.fill")
            }
            .frame(width: 100, height: 100)
            .border(Color.gray)
            TextField("Título", text: $title)
            TextField("Descripción", text: $detail)
            TextField("Precio", text: $price)
            Button {
                viewModel.uploadPruduct(title: title, detail: detail, price: Int(price) ?? 0, image: (imageData?.asUIImage().pngData())!, dataArray: storeData)
            } label: {
                Text("Agregar Producto")
            }
            Spacer()
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
    ProductUploadSwiftUIView(storeData: ProductsModel(product: [ProductModel(title: "", detail: "", image: "", price: 0)]))
}

// DocumentPicker that conforms to UIViewControllerRepresentable
struct DocumentPicker: UIViewControllerRepresentable {
    var supportedTypes: [UTType] = [.image, .pdf, .text]
    var onDocumentsPicked: ([URL]) -> Void
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
    
    // Create a Coordinator to act as the delegate
    func makeCoordinator() -> Coordinator {
        Coordinator(onDocumentsPicked: onDocumentsPicked)
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var onDocumentsPicked: ([URL]) -> Void
        
        init(onDocumentsPicked: @escaping ([URL]) -> Void) {
            self.onDocumentsPicked = onDocumentsPicked
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            onDocumentsPicked(urls)
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            print("Document picker was cancelled")
        }
    }
}
