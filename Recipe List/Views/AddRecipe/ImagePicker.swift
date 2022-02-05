//
//  ImagePicker.swift
//  Recipe List
//
//  Created by Leone on 2/1/22.
//
// Allows user to select an image from the photo library or camera

import SwiftUI

/**
 Shows view used by user to select an image from the camera or from his or her photo library.
 */
struct ImagePicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    
    // Used to choose between the camera and the photo library
    var selectedSource: UIImagePickerController.SourceType
    
    // Used to store the image given by the end user
    @Binding var recipeImage: UIImage?
    
    // Tell it the type of UIKit View Controller it should return
    func makeUIViewController(context: Context) -> UIImagePickerController {
        // TODO: Replace with PHPicker
        
        // Create IMage picker controller and return it
        let imagePickerController = UIImagePickerController()
        
        // Set the delegate
        imagePickerController.delegate = context.coordinator
        
        // By default, it goes to the photo library, but we show it here for display, so it can change to camera instead
        imagePickerController.sourceType = selectedSource
        
        // Return the ImagePickerController
        return imagePickerController
        
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    /**
     This method handles the selected image chosen by the end user. This will act as a delegate of the Image Picker.
     */
    func makeCoordinator() -> Coordinator {
        // Create a new Coordinator that refences the ImagePicker struct as a whole
        Coordinator(parent: self)
    }
    
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
     
        var parent: ImagePicker
        
        init(parent: ImagePicker) {
            // This parent equals what was passed in
            self.parent = parent 
        }
        
        /*
         Handles the events that occur once the user has selected the image.
         */
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // Check if image received
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage { // Cast this as a UIImage
                // If reach here, we were able to get the image constant, now pass back to the recipe view
                parent.recipeImage = image
            }
            // Dismiss this View
            parent.presentationMode.wrappedValue.dismiss()
        }
        
    }
    
}
