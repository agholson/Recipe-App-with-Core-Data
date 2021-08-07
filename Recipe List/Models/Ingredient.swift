//
//  Ingredient.swift
//  Recipe List
//
//  Created by Shepherd on 8/7/21.
//

import Foundation

/*
 Ingredient class, which is a dictionary of ingredients.
 
 Identifiable, let's it work in a SwiftUI list and tell each item apart
 Decodable because we parse it directly from the JSON
 */
class Ingredient: Identifiable, Decodable {
    
    var id:UUID?
    var name = ""
    // Define these as optionals, because sometimes are here”
    var num:Int?
    var unit:String?
    var denom:Int?
    
}
