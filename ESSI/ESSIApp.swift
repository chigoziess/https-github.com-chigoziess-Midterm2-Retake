//
//  ESSIApp.swift
//  ESSI
//
//  Created by Chigozie Sumani on 4/14/25.
//

import SwiftUI
import SwiftData

@main
struct ESSIApp: App {
    var body: some Scene {
        WindowGroup {
            SnackListView()
                .modelContainer(for: Snack.self)
        }
    }
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
