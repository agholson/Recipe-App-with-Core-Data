//
//  RecipeModel.swift
//  Recipe List
//
//  Created by Shepherd on 7/31/21.
//

import Foundation
import UIKit // to use for a new UIImage

class RecipeModel: ObservableObject {
    
    // Reference the managed object context used to save Core Data
    let managedObjectContext = PersistenceController.shared.container.viewContext
    
    @Published var recipes = [Recipe]()
    
    init() {
        
        // Check if app launched previously, and data loaded into the data store
        checkLoadedData()
        
    }
    
    /**
     Method checks whether/ not the Recipes were already loaded into the Core Data store from the JSON. It does this by
     looking at a key defined in the Constants file that holds a boolean on whether/ not the Recipes were loaded in the
     UserDefaults. If they were not loaded into the Data Store, then it calls another method that loads the local data into
     the Data Store.
     */
    func checkLoadedData() {
        
        // Check local storage for the falg that determiens whether/ not Core Data already loaded
        // If the key does not exist, then it will return false
        let status = UserDefaults.standard.bool(forKey: Constants.isDataPreLoaded)
        
        // If false, then load the data into Core Data
        if status == false {
            preloadLocalData()
            
        }
        
    }
    
    /**
     Loads recipes from the JSON file into the Core Data store. Meant, to be used only on the initial launch. It loops through each of the recipes and each of the ingredients
     in order to do this, then saves the Core Data versions to the data store.
     
     If the data gets successfully saved to the Core Data store, then we set the flag that it was already saved.
     */
    func preloadLocalData() {
        
        // Parse the local JSON file
        let localRecipes = DataService.getLocalData()
        
        // Create Core Data objects for each JSON recipe
        for r in localRecipes {
            // Create Recipe Core Data object inside the current managed object context
            let recipe = Recipe(context: managedObjectContext)
            
            // Set this empty Core Data recipe to match the properties from the JSON version
            recipe.cookTime = r.cookTime
            recipe.directions = r.directions
            recipe.featured = r.featured
            recipe.highlights = r.highlights
            // Set it equal to a new UUID versus the one from the JSON
            recipe.id = UUID()
            
            // Creates a new UUImage based on the passed in name of the image in the assets folder
            // Then returns the binary data from this
            // Okay, if there is no image, because the image property is optional already
            recipe.image = UIImage(named: r.name)?.jpegData(compressionQuality: 1.0)
            recipe.name = r.name
            recipe.prepTime = r.prepTime
            recipe.servings = r.servings
            recipe.summary = r.description
            recipe.totalTime = r.totalTime
            
            // Set the ingredients by looping through each one in the local file
            for i in r.ingredients {
                
                // Create an empty Core Data ingredient object
                let ingredient = Ingredient(context: managedObjectContext)
                
                // Set the properties
                ingredient.id = UUID()
                ingredient.name = i.name
                ingredient.unit = i.unit
                // Use nil coalescing operators, because these integers cannot be nil
                ingredient.num = i.num ?? 1
                ingredient.denom = i.denom ?? 1
                
                // Add this ingredient to the recipe, using the built-in method
                recipe.addToIngredients(ingredient)
                
            }
            
        }
        
        
        // Save into Core Data
        do {
            try managedObjectContext.save()
            
            // Set local storage flag, so it marks it as true that it has been loaded already
            UserDefaults.standard.setValue(true, forKey: Constants.isDataPreLoaded)
        }
        catch {
            print(error.localizedDescription)
        }
        
       
        
    }
    
    
    static func getPortion(ingredient:Ingredient, recipeServings:Int, targetServings:Int) -> String {
        
        var portion = ""
        var numerator = ingredient.num
        var denominator = ingredient.denom
        var wholePortions = 0
        
        // See if the numerator exists, otherwise, skip the below
        
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
