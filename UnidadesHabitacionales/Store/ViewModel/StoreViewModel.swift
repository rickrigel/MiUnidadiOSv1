//
//  StoreViewModel.swift
//  UnidadesHabitacionales
//
//  Created by Ricardo Sanchez on 03/11/24.
//

import Foundation

class StoreViewModel: ObservableObject {
    @Published var storeData: ProductsModel?
    @Published var getStoreSuccess: Bool = false
    @Published var shouldDismiss = false
    func getStore() {
        FirestoreService().fetchDocument(from: "products", withID: "8592a9HVkvW4M5d7lPMj", as: ProductsModel.self) { response in
            switch response {
            case .success(let data):
                self.storeData = data
                self.getStoreSuccess = true
            case .failure(let error):
                self.getStoreSuccess = false
                print(error)
            }
        }
    }
    
    func uploadPruduct(title: String, detail: String, price: Int, image: Data, dataArray: ProductsModel?) {
        FirestoreService().uploadFile(data: image, fileName: "\(title).png", fileType: "image/png") { response in
            switch response {
            case .success(let data):
                // Initialize addData as a new ProductsModel if dataArray is nil
                var addData = dataArray ?? ProductsModel(product: [])

                // Add or insert the new product
                let newProduct = ProductModel(title: title, detail: detail, image: data, price: price)
                if addData.product.isEmpty {
                    addData.product.insert(newProduct, at: 0)
                }else {
                    addData.product.append(newProduct)
                }
                FirestoreService().saveDataToFirestore(collection: "products", documentID: "8592a9HVkvW4M5d7lPMj", data: addData) { response in
                    if response == nil {
                        DispatchQueue.main.async {
                            self.shouldDismiss = true
                        }
                    }else {
                        DispatchQueue.main.async {
                            self.shouldDismiss = false
                        }
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.shouldDismiss = false
                }
                print(error)
            }
        }
    }
}
