
import Foundation

struct ToDo: Identifiable, Codable {
    var id: String = UUID().uuidString
    var  name: String
    var completed: Bool = false
    
    static var sampleData: [ToDo] = [
        .init(name: "Buy milk"),
        .init(name: "Learn Swift", completed:  true),
        .init(name: "Go for a walk"),
    ]
}
