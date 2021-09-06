//
//  RecipeModel.swift
//  Recipe List
//
//  Created by Shepherd on 7/31/21.
//

import Foundation

class RecipeModel: ObservableObject {
    @Published var recipes = [Recipe]()
    
    init() {
        // Get the recipes and set it to our recipes property
        self.recipes = DataService.getLocalData()
    }
    
    
    static func getPortion(ingredient:Ingredient, recipeServings:Int, targetServings:Int) -> String {
    
        var portion = ""
        var numerator = ingredient.num ?? 1 // Nil coalescing operator assigns to 1 if nil
        var denominator = ingredient.denom ?? 1
        var wholePortions = 0
        
        // See if the numerator exists, otherwise, skip the below
        if ingredient.num != nil {
            // Get a single serving size by multiplying denominator by the recipe servings
            denominator *= recipeServings
            
            // Get target portion by multiplying numerator by target servings
            numerator *= targetServings
            
            // Reduce fraction by greatest common divisor
            let divisor = Rational.greatestCommonDivisor(numerator, denominator)
            numerator /= divisor
            denominator /= divisor
            
            // Get the whole portion if numerator > denominator
            if numerator >= denominator {
                
                // Calculated the whole portions
                wholePortions = numerator / denominator // 5/2 = 2
                
                // Calculate the remainder
                numerator = numerator % denominator // 5/2 = 1/2
                
                // Assign to portion string
                portion += String(wholePortions)
            }
            
            // Express the remainder as a fraction
            if numerator > 0 {
                
                // Assign remainder as the portion string
                portion += wholePortions > 0 ? " " : ""
                portion += "\(numerator)/\(denominator)"
            }
            
        }
        
        
        if var unit = ingredient.unit {
            
            var suffix = ""
            
            // If whole portions greater than one, then we need it plural
            if wholePortions > 1 {
                
                // Calculate appropriate suffix
                if unit.suffix(2) == "ch" { // See if the last two characters are ch
                    unit += "es"
                }
                else if unit.suffix(1) == "f" { // ends in f like leaf
                    unit = String(unit.dropLast()) + "ves"
                }
                else {
                    unit += "s"
                }
            }
            
            
            portion += ingredient.num == nil && ingredient.denom == nil ? "" : " " // If there's no fraction, then no space
            
            return portion + unit
        }
        
        return portion
    }
}
