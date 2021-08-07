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
                List(model.recipes) { r in
                    
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
                                
                                Text(r.name)
                            }
                        })
                    
                    
                }
                .navigationBarTitle("All Recipes")
            }
            
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
