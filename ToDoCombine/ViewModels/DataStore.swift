
import Foundation

class DataStore: ObservableObject {
    @Published var toDos: [ToDo] = []
    @Published var appError: ErrorType? = nil
    
    init() {
        print(FileManager.docDirUrl.path)
        if FileManager().docExists(docName: fileName) {
            loadToDos()
        }
    }
    
    func addToDo(_ toDo: ToDo) {
        toDos.append(toDo)
        saveToDos()
    }
    
    func updateToDo(_ toDo: ToDo) {
        guard let index = toDos.firstIndex(where: { $0.id == toDo.id }) else { return }
        toDos[index] = toDo
        saveToDos()
    }
    
    func deleteToDo(at indexSet: IndexSet) {
        toDos.remove(atOffsets: indexSet)
        saveToDos()
    }
    
    func loadToDos() {
        FileManager().readDocument(docName: fileName) { (result) in
            switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    do {
                        self.toDos = try decoder.decode([ToDo].self, from: data)
                    } catch {
                        //print("Error decoding file: \(ToDoError.decodingError.localizedDescription)")
                        appError = ErrorType(error: .decodingError)
                    }
                case .failure(let error):
                    //print("Error reading file: \(error.localizedDescription)")
                    appError = ErrorType(error: error)
            }
        }
    }
    
    func saveToDos() {
        print("Saving toDos to file system eventually")
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(toDos)
            let jsonString = String(decoding: data, as: UTF8.self)
            FileManager().saveDocument(contents: jsonString, docName: fileName) { (error) in
                if let error = error {
                    //print("Error encoding file: \(error.localizedDescription)")
                    appError = ErrorType(error: error)
                }
            }
        } catch {
            //print("Error saving file: \(ToDoError.encodingError.localizedDescription)")
            appError = ErrorType(error: .encodingError)
        }
    }
    
}
