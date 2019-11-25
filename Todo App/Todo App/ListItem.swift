//
//  ListItem.swift
//  Todo App
//
//  Created by Viktor Kirillov on 11/21/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SwiftUI
import Combine

class TodoObserver: ObservableObject {
    var objectWillChange = PassthroughSubject<Void, Never>()
    
    private var todo: TodoItem
    private var saveFunc: ()->();
    
    var title: String {
        didSet {
            updateUI()
            todo.setValue(self.title, forKey: "data")
            self.saveFunc()
        }
    }
    
    var completed: Bool {
        didSet {
            updateUI()
            todo.setValue(self.completed, forKey: "completed")
            self.saveFunc()
        }
    }
    
    init(
        _ todo: TodoItem,
        _ f: @escaping ()->()
    ){
        self.todo = todo
        self.saveFunc = f
        
        self.title = todo.data ?? ""
        self.completed = todo.completed
    }
    
    func updateUI() {
        objectWillChange.send()
    }
}

struct ListItem: View {
    @ObservedObject var model: TodoObserver
    
    init(todoItem item: TodoItem, saveFunc f: @escaping ()->() ){
        model = TodoObserver(item, f)
    }
    
    var body: some View {
        HStack {
            Image(systemName: model.completed ? "checkmark.square" : "square")
                .onTapGesture {
                    self.model.completed.toggle()
                }
            TextField("What to do next?", text: $model.title)
                .disabled(model.completed)
                .foregroundColor(model.completed ? .gray : .black)
                .onTapGesture(count: 2) {
                    if self.model.completed {
                        self.model.completed.toggle()
                    }
                }
            Spacer()
            Image(systemName: "info.circle")
                .foregroundColor(.blue)
                .opacity(0.8)
        }
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItem(todoItem: TodoItem(), saveFunc: {})
            .previewLayout(.sizeThatFits)
    }
}
