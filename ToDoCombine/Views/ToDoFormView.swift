
import SwiftUI

struct ToDoFormView: View {
    @EnvironmentObject var dataStore: DataStore
    @ObservedObject var formVM: ToDoFormViewModel
    enum Field {
        case todo
    }
    @FocusState private var focusedField: Field?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            Form {
                VStack(alignment: .leading) {
                    TextField("ToDo", text: $formVM.name)
                        .focused($focusedField, equals: .todo)
                    Toggle("Completed", isOn: $formVM.completed)
                }
            }
            .task {
                focusedField = .todo
            }
            .navigationTitle("ToDo")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: cancelButton, trailing: updateSaveButton)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button {
                            focusedField = nil
                        } label: {
                            Image(systemName: "keyboard.chevron.compact.down")
                        }
                    }
                }
            }
        }
    }
}

extension ToDoFormView {
    func updateToDo() {
        let toDo =  ToDo(id: formVM.id!, name: formVM.name, completed: formVM.completed)
        dataStore.updateToDo.send(toDo)
        dismiss()
    }
    
    func addToDo() {
        let toDo = ToDo(name: formVM.name)
        dataStore.addToDo.send(toDo)
        dismiss()
    }
    
    var cancelButton: some View {
        Button("Cancel") {
            dismiss()
        }
    }
    
    var updateSaveButton: some View {
        Button( formVM.updating ? "Update" : "Save",
                action: formVM.updating ? updateToDo : addToDo)
        .disabled(formVM.isDisabled)
    }
}

#Preview {
    ToDoFormView(formVM: ToDoFormViewModel())
        .environmentObject(DataStore())
}
