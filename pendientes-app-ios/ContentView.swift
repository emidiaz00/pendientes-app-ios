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
    private let todosKey: String = "todosKey"
    
    
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
                        self.saveTodos()
                    }) {
                        Image(systemName: "plus")
                    }
                }.padding()
                List {
                    ForEach(allTodos) {todoItem in
                        Text(todoItem.todo)
                    }.onDelete(perform: deleteTodos)
                }
            }.navigationBarTitle("Pendientes", displayMode: .inline)
        }.onAppear(perform: loadTodos)
    }
    
    private func loadTodos() {
        // read data and convert information to list todo items
        if let todosData = UserDefaults.standard.value(forKey: "todosKey") as? Data {
            if let todosList = try? PropertyListDecoder().decode(Array<TodoItem>.self, from: todosData) {
                self.allTodos = todosList
            }
        }
    }
    
    private func saveTodos() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(self.allTodos), forKey: "todosKey")
    }
    
    private func deleteTodos(at offsets: IndexSet) {
        self.allTodos.remove(atOffsets: offsets)
        saveTodos()
    }
    
    
}


struct TodoItem: Codable, Identifiable {
    let id = UUID()
    let todo: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
