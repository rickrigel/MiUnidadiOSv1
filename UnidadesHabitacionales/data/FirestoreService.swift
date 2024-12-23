//
//  FirestoreService.swift
//  UnidadesHabitacionales
//
//  Created by Ricardo Sanchez on 27/10/24.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class FirestoreService {
    private let db = Firestore.firestore()
    
    // Fetch data from a collection
    func fetchData(from collection: String, completion: @escaping (Result<[DocumentSnapshot], Error>) -> Void) {
        db.collection(collection).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = querySnapshot {
                completion(.success(snapshot.documents))
            }
        }
    }
    
    // Fetch a specific document by ID
    func fetchDocument<T: Decodable>(from collection: String, withID documentID: String, as type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
            db.collection(collection).document(documentID).getDocument { (documentSnapshot, error) in
                if let error = error {
                    completion(.failure(error))
                } else if let document = documentSnapshot {
                    do {
                        let data = try document.data(as: type) // Decode directly here
                        completion(.success(data))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(NSError(domain: "FirestoreServiceError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Document data was empty."])))
                }
            }
        }
    
    // Save data to firestore
    func saveDataToFirestore<T: Codable>(
        collection: String,
        documentID: String? = nil,
        data: T,
        completion: @escaping (Error?) -> Void
    ) {
        let db = Firestore.firestore()
        
        do {
            // Convert the Codable struct to a dictionary
            let dataDictionary = try data.toDictionary()

            if let documentID = documentID {
                // Save with a specified document ID
                db.collection(collection).document(documentID).setData(dataDictionary) { error in
                    completion(error)
                }
            } else {
                // Save with an auto-generated document ID
                db.collection(collection).addDocument(data: dataDictionary) { error in
                    completion(error)
                }
            }
        } catch {
            completion(error)
        }
    }
    
    // Function to upload image or document to Firebase Storage and save URL to Firestore
    func uploadFile(data: Data, fileName: String, fileType: String, completion: @escaping (Result<String, Error>) -> Void) {
        // Create a reference to Firebase Storage
        let storageRef = Storage.storage().reference().child("uploads/\(fileName)")
        
        // Metadata for the file (optional)
        let metadata = StorageMetadata()
        metadata.contentType = fileType // e.g., "image/jpeg" or "application/pdf"
        
        // Upload the file
        storageRef.putData(data, metadata: metadata) { metadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Retrieve the download URL
            storageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let downloadURL = url else {
                    completion(.failure(NSError(domain: "URL error", code: 0, userInfo: nil)))
                    return
                }
                
                completion(.success(downloadURL.absoluteString))
            }
        }
    }
}

