//
//  AddMetaData.swift
//  Recipe List
//
//  Created by Leone on 1/30/22.
//

import SwiftUI

struct AddMetaData: View {
    
    @Binding var name: String
    @Binding var summary: String
    @Binding var prepTime: String
    @Binding var cookTime: String
    @Binding var totalTime: String
    @Binding var servings: String
    
    var body: some View {
        Group {
            // Name field
            HStack {
                Text("Name:")
                TextField("Tuna Casserole", text: $name )
            }
            
            // Summary field
            HStack {
                Text("Summary:")
                TextField("A delicious meal for the whole family", text: $summary)
            }
            
            // Prep time field
            HStack {
                Text("Prep Time:")
                TextField("1 hour", text: $prepTime)
            }
            
            // Cook time field
            HStack {
                Text("Cook Time:")
                TextField("2 hours", text: $cookTime)
            }
            
            // Total time field
            HStack {
                Text("Total Time:")
                TextField("3 hours", text: $totalTime)
            }
            
            // Servings field
            HStack {
                Text("Servings: ")
                TextField("6", text: $servings)
            }
        }
    }
}

struct AddMetaData_Previews: PreviewProvider {
    static var previews: some View {
        AddMetaData(
            name: Binding.constant("Lasagna"),
            summary: Binding.constant("Famous heavy Italain dish"),
            prepTime: Binding.constant("30 minutes"),
            cookTime: Binding.constant("45 minutes"),
            totalTime: Binding.constant("2 hours"),
            servings: Binding.constant("4")
        )
    }
}
