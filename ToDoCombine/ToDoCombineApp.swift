
import SwiftUI

@main
struct ToDoCombineApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(DataStore())
        }
    }
}
