//
//  RecipeDetailView.swift
//  Recipe List
//
//  Created by Shepherd on 7/31/21.
//

import SwiftUI

struct RecipeDetailView: View {
    
    var recipe:Recipe
    
    @State var selectedServingSize = 2
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // MARK: Recipe Image
                let image = UIImage(data: recipe.image ?? Data()) ?? UIImage()
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                
                // MARK: Recipe title
                Text(recipe.name)
                    .bold()
                    .padding(.top, 20)
                    .padding(.leading)
                    .font(Font.custom("Avenir Heavy", size: 24))
                
                // MARK: Recipe serving size picker
                VStack (alignment: .leading) {
                    Text("Select your serving size:")
                        .font(Font.custom("Avenir", size: 15))
                    Picker("", selection: $selectedServingSize) {
                        Text("2").tag(2)
                        Text("4").tag(4)
                        Text("6").tag(6)
                        Text("8").tag(8)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width:160)
                    .font(Font.custom("Avenir", size: 15))
                }
                .padding()
                
                // MARK: Ingredients
                VStack(alignment: .leading) {
                    Text("Ingredients")
                        .font(Font.custom("Avenir Heavy", size: 16))
                        .padding([.bottom, .top], 5)
                    
                    // Because it now is an NSSet, we need to specify another property to return it as an Array, then type cast it to the type we need
                    ForEach (recipe.ingredients.allObjects as! [Ingredient]) { item in
                        
                        Text("• " + RecipeModel.getPortion(ingredient: item, recipeServings: Int(recipe.servings), targetServings: selectedServingSize) + " " + item.name.lowercased())
                            .font(Font.custom("Avenir", size: 15))
                        
                    }
                    
                }
                .padding(.horizontal)
                
                // MARK: Divider
                Divider()
                
                // MARK: Directions
                VStack(alignment: .leading) {
                    Text("Directions")
                        .font(Font.custom("Avenir Heavy", size: 16))
                        .padding([.bottom, .top], 5)
                    
                    // Loop through each direction
                    ForEach (0..<recipe.directions.count, id: \.self) { index in
                        Text("\(index+1)) \(recipe.directions[index])")
                            .padding(.bottom, 5)
                            .font(Font.custom("Avenir", size: 15))
                    }
                }
                .padding(.horizontal)
                
            }
                
            
        }
        
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        let model = RecipeModel()
        
        RecipeDetailView(recipe: model.recipes[0])
        
        
    }
}

extension String {
    var capitalizedFirstLetter: String {
        self.prefix(1).uppercased() + self.dropFirst()
    }
}