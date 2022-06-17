//
//  LegoApp.swift
//  Lego
//
//  Created by Cristiano  Santos on 16/06/22.
//

import SwiftUI

@main
struct LegoApp: App {
    var body: some Scene {
        let game = LegoMemoryGame()
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
