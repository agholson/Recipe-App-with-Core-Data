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
    
    // List typ recipe metadata
    @State private var highlights = [String]()
    @State private var directions = [String]()
    
    var body: some View {
        VStack {
            
            // MARK: - Form controls
            HStack {
                Button("Clear form") {
                    // Clears the form
                }
                
                Spacer()
                
                // Add button
                Button("Add") {
                    // Adds the new recipe to core data
                    
                    // Clears the form
                }

            }
            
            
            ScrollView(showsIndicators: false) {
                VStack {
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
                    
                    
                }
            }
            
        }
        .padding(.horizontal)
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}
