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
}
