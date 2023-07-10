//
//  ContentView.swift
//  pendientes-app-ios
//
//  Created by Emiliano Diaz on 06/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var newTodo = ""
    @State private var allTodos: [TodoItem] = []
    
    
    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    TextField("Agregar pendientes...", text: $newTodo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action:  {
                        guard !self.newTodo.isEmpty else { return }
                        self.allTodos.append(TodoItem(todo: self.newTodo))
                        self.newTodo = ""
                    }) {
                        Image(systemName: "plus")
                    }
                }.padding()
                List {
                    ForEach(allTodos) {todoItem in
                        Text(todoItem.todo)
                    }
                }
            }.navigationBarTitle("Pendientes", displayMode: .inline)
        }
    }
}


struct TodoItem: Identifiable {
    let id = UUID()
    let todo: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
