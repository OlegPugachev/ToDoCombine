//
//  ContentView.swift
//  ToDoCombine
//
//  Created by Oleg on 28.01.2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataStore: DataStore
    @State private var modalType: ModalType? = nil
    var body: some View {
        NavigationView {
            List() {
                ForEach(dataStore.toDos) { toDo in
                    Button {
                        modalType = .update(toDo)
                    } label: {
                        Text(toDo.name)
                            .font(.title3)
                            .strikethrough(toDo.completed)
                            .foregroundColor(toDo.completed ? .green : Color(.label))
                    }
                }
                .onDelete(perform: dataStore.deleteToDo)
            }
            .listStyle(InsetGroupedListStyle())
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("My ToDos")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        modalType = .new
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .sheet(item: $modalType) { $0
//                modalType in
//                modalType
            }
            .alert(item: $dataStore.appError) { appError in
                Alert(title: Text("Alert !!!"), message:
                        Text(appError.error.localizedDescription))
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(DataStore())
}
