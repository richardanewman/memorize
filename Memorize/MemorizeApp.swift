//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Rick Newman on 2/13/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGameViewModel()

    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
