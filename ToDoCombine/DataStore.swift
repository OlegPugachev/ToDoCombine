//
//  DataStore.swift
//  ToDoCombine
//
//  Created by Oleg on 28.01.2025.
//

import Foundation

class DataStore: ObservableObject {
    @Published var toDos: [ToDo] = []
    
    init() {
        loadToDos()
    }
    
    func addToDo(_ toDo: ToDo) {
        toDos.append(toDo)
    }
    
    func updateToDo(_ toDo: ToDo) {
//        if let index = toDos.firstIndex(of: toDo) {
//            toDos[index] = toDo
//        }
    }
    
    func deleteToDo(at indexSet: IndexSet) {
        
    }
    
    func loadToDos() {
        toDos = ToDo.sampleData
    }
    
    func saveToDos() {
        print("Saving toDos to file system eventually")
    }
    
}
