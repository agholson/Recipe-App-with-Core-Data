//
//  Recipe.swift
//  Recipe List
//
//  Created by Shepherd on 7/31/21.
//

import Foundation

class RecipeJSON: Identifiable, Decodable {
    
    // Unique ID we assign later
    var id:UUID?
    
    // Names must match perfectly with JSON data
    // If we don't want a property, we don't need to make it here
    var name = ""
    var featured: Bool
    var image:String
    var description:String
    var prepTime:String
    var totalTime:String
    var cookTime: String 
    var servings:Int
    var highlights:[String]
    // Ingredients is an array of Ingredient classes
    var ingredients:[IngredientJSON]
    var directions:[String]
}
