//
//  SearchBarView.swift
//  Recipe List
//
//  Created by Leone on 1/27/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct SearchBarView: View {
    
    // Pass in the State property from the above View
    @Binding var filterBy: String
    
    var filterByHasText: Bool {
        // If the filter text has data, then zoom in on it
        if filterBy != "" {
            return true
        }
        // Else do not zoom in on it
        return false
    }
    
    // Zooms in on the search bar in iOS 15
    @FocusState private var zoomSearch: Bool 
    
    var body: some View {
        
        // Create a rectangle to display for the Search text
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(5)
                .shadow(radius: 4)
            
            // Used to display magnifying glass next to the text field
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Filter by...", text: $filterBy)
                    .focused($zoomSearch)
                
                // Only display the delete button if the filterBy contains some text
                
                if filterBy != "" {
                    // Create a delete button in the text search
                    Button {
                        // Clear the current text on press
                        filterBy = ""
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                    
                    }
                }
            }
            .padding()
        }
        .frame(height: 48) // Makes entire box 48 pixels tall
        .foregroundColor(.gray) // Makes all text/ elements gray
    }
}

struct SearchBarView_Previews: PreviewProvider {
    
    static var previews: some View {
        if #available(iOS 15.0, *) {
            SearchBarView(filterBy: Binding.constant("Spaghetti"))
        } else {
            // Fallback on earlier versions
        }
    }
}
