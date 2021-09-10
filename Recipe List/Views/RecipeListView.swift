//
//  ContentView.swift
//  Recipe List
//
//  Created by Shepherd on 7/31/21.
//

import SwiftUI

struct RecipeListView: View {
    
    // MARK: Read the Environment Object
    @EnvironmentObject var model:RecipeModel
    
    var body: some View {
        
        VStack {
            
            NavigationView {
                
                VStack(alignment: .leading) {
                    
                    // Title
                    Text("All recipes")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                    
                    // Use a ScrollView to allow for the nice scrolling interfaces
                    ScrollView {
                        // Creates items only as needed
                        LazyVStack(alignment: .leading) {
                            // Use the ForEah for more control over our views
                            ForEach(model.recipes) { r in
                                NavigationLink(
                                    destination: RecipeDetailView(recipe: r),
                                    label: {
                                        // MARK: Recipe Image & Name
                                        HStack(spacing: 20.0) {
                                            // Clip cuts image outside of frame
                                            Image(r.image)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                .clipped()
                                                .cornerRadius(5)
                                            // MARK: Recipe Name + Highlights
                                            VStack(alignment: .leading) {
                                                Text(r.name)
                                                    .bold()
                                                // Add highlights
                                                RecipeHighlights(highlights: r.highlights)
                                            }
                                            .foregroundColor(.black)
                                        }
                                    })
                                
                                
                            } // Removes extra whitespace at the top
                            .navigationBarHidden(true)
                        }
                        
                    }
                    
                }
                    .padding()
            }
            
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
            .environmentObject(RecipeModel())
    }
}
