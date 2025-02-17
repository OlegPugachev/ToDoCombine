
import SwiftUI

@main
struct ToDoCombineApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DataStore())
                .onAppear {
//                    UserDefaults
//                        .standard
//                        .setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable") //disable console warnings
                }
            
        }
    }
}
