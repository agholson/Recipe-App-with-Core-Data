//
//  RecipeTabView.swift
//  Recipe List
//
//  Created by Shepherd on 8/3/21.
//

import SwiftUI

struct RecipeTabView: View {
    
    // Used to switch tab views after the user adds a new recipe
    @State private var tabSelection = 0
    
    var body: some View {
        // Bind selection to the tabSelection to switch views programmatically
        TabView(selection: $tabSelection) {
            
            // MARK: Featured View
            // Use a View in order to create a new tab
            RecipeFeaturedView()
                .tabItem {
                    VStack {
                        Image(systemName: "star.fill")
                        Text("Featured")
                    }
                }
                .tag(Constants.featuredTab)
            
            // MARK: List View
            RecipeListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Recipes")
                }
                .tag(Constants.listTab)
            
            // MARK: Add Recipe View
            AddRecipeView(tabSelection: $tabSelection)
                .tabItem {
                    Image(systemName: "plus.circle")
                    Text("Add")
                }
                .tag(Constants.addRecipeTab)
            
        }
        .environmentObject(RecipeModel())
        
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
    }
}
