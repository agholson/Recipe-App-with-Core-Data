//
//  RecipeTabView.swift
//  Recipe List
//
//  Created by Shepherd on 8/3/21.
//

import SwiftUI

struct RecipeTabView: View {
    var body: some View {
        
        TabView {
            
            // MARK: Featured View
            RecipeFeaturedView()
                .tabItem {
                    VStack {
                        Image(systemName: "star.fill")
                        Text("Featured")
                    }
                }
            
            // MARK: List View
            RecipeListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Recipes")
                }
            
        }
        .environmentObject(RecipeModel())
        
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
    }
}
