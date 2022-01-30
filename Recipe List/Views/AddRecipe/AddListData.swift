//
//  AddListData.swift
//  Recipe List
//
//  Created by Leone on 1/30/22.
//

import SwiftUI

struct AddListData: View {
    
    @Binding var list: [String]
    
    // Used to hold user input
    @State private var item: String = ""
    
    let title: String
    let placeHolderText: String
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text("\(title):")
                    .bold()
                TextField("\(placeHolderText)", text: $item)
                
                Button("Add") {
                    // Adds the user inputted item to the list, if not blank
                    if item.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                        list.append(item)
                        // Clear the value of item
                        item = ""
                    }
                }
            }
            
            // Show current items in the list
            ForEach(list, id: \.self) { item in
                Text(item.trimmingCharacters(in: .whitespacesAndNewlines))
            }
            
        }
    }
}

//struct AddListData_Previews: PreviewProvider {
//    static var previews: some View {
//        let previewList =
//        AddListData(list: Binding.constant(["Spicy, Easy to make"]), item: "Tasty", title: "Highlights", placeHolderText: "Tasty")
//    }
//}
