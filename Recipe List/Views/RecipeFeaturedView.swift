//
//  RecipeFeaturedView.swift
//  Recipe List
//
//  Created by Shepherd on 8/7/21.
//

import SwiftUI

/**
 Displays the featured recipes after pulling the information from the Core Data store.
 */
struct RecipeFeaturedView: View {
        
    @State var isDetailViewShowing = false // Tracks whether/ not to show our detailed view
    @State var tabSelectionIndex = 0
    
    // Get the Fetched results from Core Data in alphabetical order for only the featured Views
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)],
        predicate: NSPredicate(format: "featured == true")
    )
    var recipes: FetchedResults<Recipe>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // MARK: Custom Font Title
            Text("Featured Recipes")
                .fontWeight(.bold)
                .padding(.leading)
                .padding(.top)
                .font(Font.custom("Avenir Heavy", size: 24))
            
            // Use TabView to display a card with the food
            GeometryReader { geo in
                
                TabView(selection: $tabSelectionIndex) {
                    
                    // Create a Rectange ForEach recipe. Goes from zero to one less than the array length
                    ForEach(0..<recipes.count) { index in
                        
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
                                
                                // MARK: Image + Name
                                VStack(spacing: 0) {
                                    
                                    // Loads the binary data, if nil, then makes it an empty UIImage
                                    let image = UIImage(data: recipes[index].image ?? Data()) ?? UIImage()
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                    Text(recipes[index].name)
                                        .padding(5)
                                        .font(Font.custom("Avenir", size: 15))
                                }
                            }
                        })
                            .tag(index)  // Writes the current index as the tab selected index state variable
                            .sheet(isPresented: $isDetailViewShowing) { // Makes our view slide up
                                // Show the recipe detail view
                                RecipeDetailView(recipe: recipes[index])
                            }
                            .buttonStyle(PlainButtonStyle())  // Takes away the blue link
                            .frame(width: geo.size.width - 40, height: geo.size.height - 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        // Always specifiy corner radius before shadow
                            .cornerRadius(15)
                            .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5), radius: 10, x: -5, y: 5)
                        
                    }
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
            }
            
            // MARK: Bottom Text
            VStack(alignment: .leading, spacing: 5) {
                Text("Preparation Time: ")
                    .font(Font.custom("Avenir Heavy", size: 16))
                Text(recipes[tabSelectionIndex].prepTime)
                Text("Highlights:")
                    .font(Font.custom("Avenir Heavy", size: 16))
                RecipeHighlights(highlights: recipes[tabSelectionIndex].highlights)
                
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
        let index = recipes.firstIndex { (recipe) -> Bool in
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
