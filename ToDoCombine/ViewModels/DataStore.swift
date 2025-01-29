
import Foundation
import Combine

class DataStore: ObservableObject {
    @Published var toDos: [ToDo] = []
    @Published var appError: ErrorType? = nil
    var addToDo = PassthroughSubject<ToDo, Never>()
    var updateToDo = PassthroughSubject<ToDo, Never>()
    var deleteToDo = PassthroughSubject<IndexSet, Never>()
    
    var subscription = Set<AnyCancellable>()
    
    init() {
        print(FileManager.docDirUrl.path)
        addSubscriptions()
        if FileManager().docExists(docName: fileName) {
            loadToDos()
        }
    }
    
    func addSubscriptions() {
        addToDo
            .sink{[unowned self] toDo in
                toDos.append(toDo)
                saveToDos()
            }
            .store(in: &subscription)
        
        updateToDo
            .sink{[unowned self] toDo in
                guard let index = toDos.firstIndex(where: { $0.id == toDo.id }) else { return }
                toDos[index] = toDo
                saveToDos()
            }
            .store(in: &subscription)
        
        deleteToDo
            .sink {[unowned self] indexSet in
                toDos.remove(atOffsets: indexSet)
                saveToDos()
            }
            .store(in: &subscription)
    }
    
//    func addToDo(_ toDo: ToDo) {
//        toDos.append(toDo)
//        saveToDos()
//    }
    
//    func updateToDo(_ toDo: ToDo) {
//        guard let index = toDos.firstIndex(where: { $0.id == toDo.id }) else { return }
//        toDos[index] = toDo
//        saveToDos()
//    }
//    
//    func deleteToDo(at indexSet: IndexSet) {
//        toDos.remove(atOffsets: indexSet)
//        saveToDos()
//    }
//    
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
