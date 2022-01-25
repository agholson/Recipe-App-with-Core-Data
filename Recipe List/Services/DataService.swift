//
//  DataService.swift
//  Recipe List
//
//  Created by Shepherd on 7/31/21.
//

import Foundation

class DataService {
    
    /**
     This static method parses a list of local JSON recipes into RecipeJSON data classes
        - returns: List of RecipeJSON objects
    */
    static func getLocalData() -> [RecipeJSON] {
       
        // Parse local JSON file
        let filePath = Bundle.main.path(forResource: "recipes", ofType: "json")

        // Ensure the path exists, otherwise return an empty list of Recipes
        guard filePath != nil else {
            // Else return an empty recipe list
            return [RecipeJSON]()

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
                let recipeData = try decoder.decode([RecipeJSON].self, from: data)

                // Add unique IDs here
                for r in recipeData {
                    r.id = UUID()

                    // Also loop through ingredient list to add unique ID
                    for ingredient in r.ingredients {
                        ingredient.id = UUID()
                    }

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
        return [RecipeJSON]()

    }
}
