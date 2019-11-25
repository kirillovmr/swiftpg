//
//  TodoList.swift
//  Todo App
//
//  Created by Viktor Kirillov on 11/22/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SwiftUI

struct TodoList: View {
    @Environment(\.managedObjectContext) var managedObjectContext;
    
    @FetchRequest(
        entity: TodoItem.entity(),
        sortDescriptors: [
            NSSortDescriptor(key: "completed", ascending: true),
            NSSortDescriptor(key: "timestamp", ascending: true),
        ]
    ) var todos: FetchedResults<TodoItem>
    
    func createEmptyTodo() {
        let todo = TodoItem(context: self.managedObjectContext)
        todo.data = ""
        todo.completed = false
        todo.timestamp = Date()
        saveData()
    }
    
    func deleteData(at offsets: IndexSet) {
        for index in offsets {
            let todo = todos[index]
            managedObjectContext.delete(todo)
        }
        saveData()
    }
    
    func deleteCompleted() {
        for todo in todos {
            if todo.completed {
                managedObjectContext.delete(todo)
            }
        }
        saveData()
    }
    
    func saveData() {
        do { try self.managedObjectContext.save() }
        catch { print("Error saving empty todo") }
        print("Data saved")
    }
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(todos, id:\.self) { (todo: TodoItem) in
                        ListItem(todoItem: todo, saveFunc: self.saveData)
                    }
                    .onDelete(perform: deleteData)
                }.navigationBarTitle("Reminders (\(todos.count))")
            }
            Spacer()
            HStack {
                Button(action: createEmptyTodo) {
                    HStack {
                        Image(systemName: "plus.square")
                        Text("Add new item")
                    }
                }
                Spacer()
                Button(action: deleteCompleted) {
                    HStack {
                        Image(systemName: "bin.xmark")
                        Text("Delete completed")
                    }
                }
            }
            .padding()
        }
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoList()
    }
}
