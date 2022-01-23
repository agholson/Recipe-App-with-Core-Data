//
//  Recipe_ListApp.swift
//  Recipe List
//
//  Created by Shepherd on 7/31/21.
//

import SwiftUI

@main
struct Recipe_List_App: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        
        WindowGroup {
            RecipeTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
