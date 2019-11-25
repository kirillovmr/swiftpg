//
//  ContentView.swift
//  Todo App
//
//  Created by Viktor Kirillov on 11/21/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // Connecting CoreData
    @Environment(\.managedObjectContext) var managedObjectContext;
    
    @FetchRequest(
        entity: ProgLang.entity(),
        sortDescriptors: []
    ) var languages: FetchedResults<ProgLang>
    
    func removeLanguages(at offsets: IndexSet) {
        for index in offsets {
            let language = languages[index]
            managedObjectContext.delete(language)
        }
        // Saving
        do {
            try managedObjectContext.save()
        } catch {
            // handle the Core Data error
        }
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(languages, id: \.self) { language in
                    Text("Creator: \(language.creator ?? "Anonymous")")
                }.onDelete(perform: removeLanguages)
            }
            Text("Hello")
            Button(action: {
                let language = ProgLang(context: self.managedObjectContext)
                language.name = "Python"
                language.creator = "Guido van Rossum"

                do {
                    try self.managedObjectContext.save()
                } catch {
                    print("Error saving")
                }
                
            }) {
                Text("Insert example language")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
