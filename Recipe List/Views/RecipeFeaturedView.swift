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
    
    @State var isDetailViewShowing = false // Tracks whether/ not to show our detailed view
    @State var tabSelectionIndex = 0
        
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Featured Recipes")
                .fontWeight(.bold)
                .padding(.leading)
                .padding(.top)
                .font(.largeTitle)
                
            // Use TabView to display a card with the food
            GeometryReader { geo in
                
                TabView(selection: $tabSelectionIndex) {
                
                // Create a Rectange ForEach recipe. Goes from zero to one less than the array length
                    ForEach(0..<model.recipes.count) { index in
                        
                        // Check if the current recipe is featured
                        if model.recipes[index].featured {
                            
                            // MARK: Recipe Card
                            
                            // Recipe button
                            Button(action: {
                                // Set the isDetailViewShowing to true, when user taps here
                                self.isDetailViewShowing = true
                                
                            }, label: {
                                // Use ZStack as the label
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.white)
                                    
                                    // Image
                                    VStack(spacing: 0) {
                                        Image(model.recipes[index].image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .clipped()
                                        Text(model.recipes[index].name)
                                            .padding(5)
                                    }
                                }
                            })
                            .tag(index)  // Writes the current index as the tab selected index state variable
                            .sheet(isPresented: $isDetailViewShowing) { // Makes our view slide up
                                // Show the recipe detail view
                                RecipeDetailView(recipe: model.recipes[index])
                            }
                            .buttonStyle(PlainButtonStyle())  // Takes away the blue link
                            .frame(width: geo.size.width - 40, height: geo.size.height - 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            // Always specifiy corner radius before shadow
                            .cornerRadius(15)
                            .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5), radius: 10, x: -5, y: 5)
                        }
                    }
            
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
        }
            
        // MARK: Bottom Text
        VStack(alignment: .leading, spacing: 5) {
            Text("Preparation Time: ")
                .font(.headline)
            Text(model.recipes[tabSelectionIndex].prepTime)
            Text("Highlights:")
                .font(.headline)
            RecipeHighlights(highlights: model.recipes[tabSelectionIndex].highlights)
//            Text(model.recipes[tabSelectionIndex].highlights)
                
        }
        .padding([.leading, .bottom])
        
        }
        // Run this code to set the proper index as soon as the view appears
        .onAppear(perform: {
            setFeaturedIndex()
        })
    }
    
    func setFeaturedIndex () {
       // Find the index of the first featured recipe
        
        // Returns the first index, where the closure is met
        let index = model.recipes.firstIndex { (recipe) -> Bool in
            return recipe.featured // Returns true only if the recipe was featured
        }
        
        // If it can't find any recipes as featured, then this sets the value equal to zero
        tabSelectionIndex = index ?? 0
        
    }
}

struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView()
            .environmentObject(RecipeModel())
    }
}
