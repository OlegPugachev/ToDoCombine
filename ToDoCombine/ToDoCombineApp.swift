//
//  ToDoCombineApp.swift
//  ToDoCombine
//
//  Created by Oleg on 28.01.2025.
//

import SwiftUI

@main
struct ToDoCombineApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(DataStore())
        }
    }
}
