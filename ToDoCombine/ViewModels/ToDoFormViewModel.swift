//
//  ToDoFormViewModel.swift
//  ToDoCombine
//
//  Created by Oleg on 28.01.2025.
//

import Foundation

class ToDoFormViewModel: ObservableObject {
    @Published var name = ""
    @Published var completed = false
    var id: String?
    
    var updating: Bool { id != nil }
    
    var isDisabled: Bool { name.isEmpty }
    
    init() {}
    
    init(_ currentToDo: ToDo) {
        self.name = currentToDo.name
        self.completed = currentToDo.completed
        self.id = currentToDo.id
       
    }
}
