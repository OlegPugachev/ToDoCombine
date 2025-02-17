
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataStore: DataStore
    @State private var modalType: ModalType? = nil
    var body: some View {
        NavigationView {
            List() {
                ForEach(dataStore.toDos.value) { toDo in
                    Button {
                        modalType = .update(toDo)
                    } label: {
                        Text(toDo.name)
                            .font(.title3)
                            .strikethrough(toDo.completed)
                            .foregroundColor(toDo.completed ? .green : Color(.label))
                    }
                }
                .onDelete(perform: dataStore.deleteToDo.send)
            }
            .listStyle(.insetGrouped)
            .navigationBarTitle("My ToDos")
            .navigationBarItems(
                trailing:
                    Button {
                        modalType = .new
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
            )
            .sheet(item: $modalType) { $0
//                modalType in
//                modalType
            }
            .alert(item: $dataStore.appError.value) { appError in
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
