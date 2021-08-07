//
//  RecipeFeaturedView.swift
//  Recipe List
//
//  Created by Shepherd on 8/7/21.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    // Inherit the RecipeModel from a higher-level view
    @EnvironmentObject var model: RecipeModel
    
    var body: some View {
        
      
        
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView()
    }
}
