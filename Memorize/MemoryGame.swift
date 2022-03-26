//
//  MemoryGame.swift
//  Memorize Model
//
//  Created by Rick Newman on 2/20/22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private var firstCardIndex: Int?

    mutating func choose(_ card: Card) {
        let selectedCard = cards[card.id]

        if firstCardIndex == nil {
            cards.indices.forEach { if cards[$0].faceUp, !cards[$0].matched { cards[$0].faceUp = false } }
            firstCardIndex = selectedCard.id
            cards[selectedCard.id].faceUp.toggle()
        } else if firstCardIndex != nil, !selectedCard.matched, !selectedCard.faceUp {
            cards[selectedCard.id].faceUp.toggle()
            let faceUpCard = cards[firstCardIndex!]
            let match = selectedCard.content == faceUpCard.content
            cards[selectedCard.id].matched = match
            cards[firstCardIndex!].matched = match
            firstCardIndex = nil
        }
    }

    init(pairs: Int, createCardContent: (Int) -> CardContent) {
        cards = []

        for pairIndex in 0 ..< pairs {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2 + 1))
        }
    }

    struct Card: Identifiable {
        var faceUp = false
        var matched = false
        let content: CardContent
        let id: Int
    }
}
