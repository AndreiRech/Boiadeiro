//
//  BoiadeiroApp.swift
//  Boiadeiro
//
//  Created by Andrei Rech on 06/08/25.
//

import SwiftUI
import SwiftData

@main
struct BoiadeiroApp: App {
    var body: some Scene {
        WindowGroup {
            TabBar()
        }
        .modelContainer(for: Batch.self)
    }
}
