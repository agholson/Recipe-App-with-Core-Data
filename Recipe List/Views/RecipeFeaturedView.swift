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
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Featured Recipes")
                .fontWeight(.bold)
                .padding(.leading)
                .padding(.top)
                .font(.largeTitle)
                
            // Use TabView to display a card with the food
            GeometryReader { geo in
                
            TabView {
                
                // Create a Rectange ForEach recipe. Goes from zero to one less than the array length
                ForEach(0..<model.recipes.count) { index in
                    
                    // Check if the current recipe is featured
                    if model.recipes[index].featured {
                        
                        // MARK: Recipe Card
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
                Text("1 hour")
                Text("Highlights:")
                    .font(.headline)
                Text("Healthy, Hearty, Filling, Fast")
                    
            }
                .padding([.leading, .bottom])
        
        }
    }
}

struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView()
            .environmentObject(RecipeModel())
    }
}
