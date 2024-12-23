//
//  DocumentPiker.swift
//  UnidadesHabitacionales
//
//  Created by Ricardo Sanchez on 27/10/24.
//

import UIKit
import UniformTypeIdentifiers

class DocumentPiker: UIViewController, UIDocumentPickerDelegate {
    
    // Function to present the document picker
    func selectDocumentOrImage() {
        // Define the types of documents you want to allow
        var supportedTypes: [UTType] = [.image, .pdf, .text, .plainText]
        
        // Initialize the document picker with UTType (iOS 14+)
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        
        // Present the document picker
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    // UIDocumentPickerDelegate method
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        // Handle the selected document
        guard let selectedFileURL = urls.first else { return }
        
        // Process the selected file URL (you could load, preview, or save it)
        print("Selected file URL: \(selectedFileURL)")
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("Document picker was cancelled")
    }
}

