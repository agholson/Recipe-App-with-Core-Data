//
//  AddIngredientData.swift
//  Recipe List
//
//  Created by Leone on 1/31/22.
//

import SwiftUI

struct AddIngredientData: View {
    
    @Binding var ingredients: [IngredientJSON]
    
    // Declare state properties for each of the ingredient properties
    @State private var name = ""
    @State private var num = ""
    @State private var denom = ""
    @State private var unit = ""
    
    // Computed property tracks if the name has a value, so it disables the add button below
    var emptyName: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return true
        }
        return false
        
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            
            Text("Ingredients:")
                .bold()
                .padding(.top, 5)
            
            // MARK: - Ingredient Input
            HStack {
                
                TextField("Sugar", text: $name)
                
                
                TextField("1", text: $num)
                // Frame makes it closer to the divisor symbol
                    .frame(width: 20)
                
                Text("/")
                
                TextField("2", text: $denom)
                
                
                TextField("cups", text: $unit)
                
                // Button
                Button("Add") {
                    
                    // Get the cleaned version of the fields
                    let cleanedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
                    let cleanedNum = num.trimmingCharacters(in: .whitespacesAndNewlines)
                    let cleanedDenom = denom.trimmingCharacters(in: .whitespacesAndNewlines)
                    let cleanedUnit = unit.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    // Make sure none are blank values
                    if cleanedName == "" || cleanedNum == "" || cleanedDenom == "" || cleanedUnit == "" {
                        return 
                    }
                    
                    // Add the new ingredient to the ingredients list
                    let newIngredient = IngredientJSON()
                    
                    // Add properties from the State variables
                    newIngredient.name = cleanedName
                    // If it is nil, then assign it a value of 1
                    newIngredient.num = Int(cleanedNum) ?? 1
                    newIngredient.denom = Int(cleanedDenom) ?? 1
                    newIngredient.unit = cleanedUnit
                    
                    // Set new ID
                    newIngredient.id = UUID()
                    
                    // Add this ingredient to the existing array
                    ingredients.append(newIngredient)
                    
                    // Clear text fields
                    name = ""
                    num = ""
                    denom = ""
                    unit = ""
                }
                .disabled(emptyName)
                
            }
            
            // MARK: - List Current Ingredients
            // Because it belongs to the Identifiable protocol already, don't need to set the id explicitly
            ForEach(ingredients) { ingredient in
                // Display name, unit,
                Text("\(ingredient.name), \(ingredient.num ?? 1)/\(ingredient.denom ?? 1) \(ingredient.unit ?? "")")
            }
            
        }
    }
}

//struct AddIngredientData_Previews: PreviewProvider {
//    static var previews: some View {
//        AddIngredientData()
//    }
//}
