//
//  RecipeHighlights.swift
//  Recipe List
//
//  Created by Shepherd on 9/8/21.
//

import SwiftUI

struct RecipeHighlights: View {
    
    var allHighlights = ""
    
    init(highlights:[String]) {
        
        // Loop through highlights to build the string
        for index in 0..<highlights.count {
            
            // If the index is our last do not add a comma
            if index == highlights.count - 1 {
                allHighlights += highlights[index]
            } // Else add the comma
            else {
                allHighlights += "\(highlights[index]), "
            }
            
            
        }
        
    }
    // Place the formatted text into the View
    var body: some View {
        Text(allHighlights)
            .font(Font.custom("Avenir", size: 15))
    }
}

struct RecipeHighlights_Previews: PreviewProvider {
    static var previews: some View {
        RecipeHighlights(highlights: ["test", "test2"])
    }
}
