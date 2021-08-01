//
//  DataService.swift
//  Recipe List
//
//  Created by Shepherd on 7/31/21.
//

import Foundation

class DataService {
    
    // Allows us to call this method without creating object of DataService
    static func getLocalData() -> [Recipe] {
        
        // Parse local JSON file
        let filePath = Bundle.main.path(forResource: "recipes", ofType: "json")
        
        // Ensure the path exists, otherwise return an empty list of Recipes
        guard filePath != nil else {
            // Else return an empty recipe list
            return [Recipe]()

        }
        
        let url = URL(fileURLWithPath: filePath!)
        
        // Read the data from the file here
        do {
            // Create a data object
            let data = try Data(contentsOf: url)
            
            // Decode the data with a JSON decoder
            let decoder = JSONDecoder()
            do {
                // Our JSON is an array of recipe data, so that's the type we use here
                let recipeData = try decoder.decode([Recipe].self, from: data)
                
                // Add unique IDs here
                for r in recipeData {
                    r.id = UUID()
                }
                
                // Return recipes
                return recipeData
                
            } catch {
                // Catch any decode errors here
                print(error)
            }
            
        } catch {
            // Error getting data
            print(error)
        }

        // We must return something, so even if it fails above, we return an empty list of jsonData
        return [Recipe]() 
        
    }
}
