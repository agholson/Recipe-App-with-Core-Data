//
//  ContentView.swift
//  Recipe List
//
//  Created by Shepherd on 7/31/21.
//

import SwiftUI

struct RecipeListView: View {
    
    
    // MARK: Read the Environment Objects
    @Environment(\.managedObjectContext) private var viewContext

//    @EnvironmentObject var model:RecipeModel
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
    private var recipes: FetchedResults<Recipe>
    
    // Tracks the text typed into the search bar`
    @State private var filterBy = ""
    
    // Use a computed property to show the actual recipes
    // As the filterBy text changes, it changes the recipes shown here 
    private var filteredRecipes: [Recipe] {
        // Check the filtered text without extra space or new lines
        if filterBy.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            // Used to catch the FectedResults as an array
            return Array(recipes)
        }
        
        // Return a subset of the list, if it contains any of the keywords in the name or in the highlights
        return recipes.filter { r in
            // Compares the uppercased versions of the strings
            if r.name.uppercased().contains(filterBy.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()) {
                return true
            }
            // Loops through the highlight words, e.g. Spicy, Easy to cook, to see if it contains the text the user typed
            for highlight in r.highlights {
                if highlight.uppercased().contains(filterBy.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()) {
                    return true
                }
            }
            // If it doesn't contain the string, then this subset isn't returned
            return false
            
            // If it contains part of the name, then include this element/ as a subset, returning true
//            return (r.name.contains(filterBy.trimmingCharacters(in: .whitespacesAndNewlines)))
            
        }
                
    }
    
    var body: some View {
        
        VStack {
            
            NavigationView {
                
                VStack(alignment: .leading) {
                    
                    // Title
                    Text("All recipes")
                        .fontWeight(.bold)
                        .font(Font.custom("Avenir Heavy", size: 24))
                    
                    // MARK: Recipe Filter
                    if #available(iOS 15.0, *) {
                        SearchBarView(filterBy: $filterBy)
                            .padding([.trailing, .bottom])
                    } else {
                        // Fallback on earlier versions
                    }
                    
                    // Use a ScrollView to allow for the nice scrolling interfaces
                    ScrollView {
                        // Creates items only as needed
                        LazyVStack(alignment: .leading) {
                            // Use the ForEah for more control over our views
                            ForEach(filteredRecipes) { r in
                                NavigationLink(
                                    destination: RecipeDetailView(recipe: r),
                                    label: {
                                        // MARK: Recipe Image & Name
                                        HStack(spacing: 20.0) {
                                            
                                            // Use a UIImage to display binary data from Core Data
                                            let image = UIImage(data: r.image ?? Data()) ?? UIImage()
                                            
                                            // Clip cuts image outside of frame
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                .clipped()
                                                .cornerRadius(5)
                                            
                                            // MARK: Recipe Name + Highlights
                                            VStack(alignment: .leading) {
                                                Text(r.name)
                                                    .font(Font.custom("Avenir Heavy", size: 16))
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
                .padding(.leading)
                .navigationBarHidden(true)
                .onTapGesture {
                    // Resign first responder, allows the user to click out of the keyboard onto the window in order to dismiss the keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil  )
                }
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
