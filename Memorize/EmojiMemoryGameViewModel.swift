//
//  EmojiMemoryGame.swift
//  Memorize ViewModel
//
//  Created by Rick Newman on 2/20/22.
//

import SwiftUI

class EmojiMemoryGameViewModel: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private static let emojis = ["🚁", "🚀", "🛸", "⛵️", "🛶", "🗿", "🏕", "🏠", "🚘"]

    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(pairs: 6) { pairIndex in
            emojis[pairIndex]
        }
    }

    @Published private var model: MemoryGame<String> = createMemoryGame()

    var cards: [Card] {
        return model.cards
    }

    func choose(_ card: Card) {
        model.choose(card)
    }
}
