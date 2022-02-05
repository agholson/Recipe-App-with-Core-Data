//
//  AddRecipeView.swift
//  Recipe List
//
//  Created by Leone on 1/28/22.
//

import SwiftUI

struct AddRecipeView: View {
    
    @State private var name = ""
    @State private var summary = ""
    @State private var prepTime = ""
    @State private var cookTime = ""
    @State private var totalTime = ""
    // Even though this is an Integer in the Data Store, accept the input as a string
    @State private var servings = ""
    
    // List type recipe metadata
    @State private var highlights = [String]()
    @State private var directions = [String]()
    
    // Recipe Image
    @State private var recipeImage: UIImage? // Optional in case user chooses not to add an image
    
    // Track the type of image view user selected
    // TODO: Replace with PHpicker
    @State private var selectedImageSource = UIImagePickerController.SourceType.photoLibrary
    // Image Picker state property used in the .sheet
    @State private var showImagePicker = false
    @State private var placeHolderImage = Image("noImageAvailable")
    
    // Ingredient data
    // Use the JSON version, so we do not automatically create a Core Data object of this
    @State private var ingredients = [IngredientJSON]()
    
    var body: some View {
        VStack {
            
            // MARK: - Form controls
            HStack {
                Button("Clear form") {
                    // Clears the form
                    clear()
                }
                
                Spacer()
                
                // Add button
                Button("Add") {
                    // Adds the new recipe to core data
                    addRecipe()
                    
                    // Clears the form
                }

            }
            
            
            ScrollView(showsIndicators: false) {
                
                
                
                VStack {
                    // Photo for user to upload
                    placeHolderImage
                        .resizable()
                        .scaledToFit()
                    
                    // Photo upload controls
                    HStack {
                        Button("Photo Library") {
                            // User taps on photo library, change the image picker showing to true
                            showImagePicker = true
                            // TODO: Replace with PHPicker
                            selectedImageSource =  .photoLibrary
                        }
                        
                        Text("|")
                        
                        Button("Camera") {
                            showImagePicker = true
                            selectedImageSource = .camera
                        }
                        
                    }
                    .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                        // Display the photo library or the camera based on user selection
                        ImagePicker(selectedSource: selectedImageSource, recipeImage: $recipeImage)
                    }
                    
                    
                    // MARK: - Form input
                    AddMetaData(
                        name: $name,
                        summary: $summary,
                        prepTime: $prepTime,
                        cookTime: $cookTime,
                        totalTime: $totalTime,
                        servings: $servings
                    )
                    
                    // MARK: - List Data
//                    AddListData(list: $highlights)
                    AddListData(list: $highlights, title: "Highlights", placeHolderText: "Seafood")
                    
                    AddListData(list: $directions, title: "Directions", placeHolderText: "Add oil to the pan")
                    
                    // Ingredient data
                    AddIngredientData(ingredients: $ingredients)
                    
                }
            }
            
        }
        .padding(.horizontal)
    }
    
    /// Used to load the image from the UIKit/ user photo library or camera
    func loadImage() {
        // Check if image selected from the library
        if recipeImage != nil {
            // Set it to the place holder image from UIKit
            placeHolderImage = Image(uiImage: recipeImage!)
        }
    }
    
    /// Clears all of the form data for the recipe
    func clear() {
        // Clear all the form fields
        name = ""
        summary = ""
        prepTime = ""
        cookTime = ""
        totalTime = ""
        servings = ""
        highlights = [String]()
        directions = [String]()
        ingredients = [IngredientJSON]()
    }
    
    /// Saves the Recipe to Core Data
    func addRecipe() {
        // Create a new Core Data Recipe object
        let newRecipe = Recipe()
        
        // Add all the properties to this new object
        newRecipe.name =    name
        newRecipe.summary = summary
        newRecipe.prepTime = prepTime
        newRecipe.cookTime = cookTime
        newRecipe.totalTime = totalTime
//        newRecipe.servings = Int(servings ?? "") ?? 1
//        newRecipe.highlights = highlights
//        newRecipe.directions = directions
        
        // For each of the directionsingredients add it to the recipe
//        for ingredient in ingredients {
            // Add the new ingredient
//            newRecipe.addToIngredients(ingredient)
//        }
        
    }
    
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}
