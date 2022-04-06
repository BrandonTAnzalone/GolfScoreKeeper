//
//  GolfScoreKeeperApp.swift
//  GolfScoreKeeper
//
//  Created by Brandon Anzalone on 3/23/22.
//

import SwiftUI

@main
struct GolfScoreKeeperApp: App {
        @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
