//
//  EmojiMemoryGameView.swift
//  Memorize View
//
//  Created by Rick Newman on 2/13/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGameViewModel

    var body: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2 / 3, content: { card in
            CardView(card: card)
                .padding(4)
                .onTapGesture {
                    game.choose(card)
                }
        })
        .foregroundColor(.red)
        .padding(.horizontal)
    }
}

struct CardView: View {
    private typealias DC = DrawingConstants
    let card: EmojiMemoryGameViewModel.Card

    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DC.cornerRadius)

                if card.matched {
                    shape.opacity(0)
                } else if card.faceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DC.lineWidth)
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90)).padding(5).opacity(0.5)
                    Text(card.content).font(fontFn(in: geometry.size))
                } else {
                    shape.fill()
                }
            }
        })
    }

    private func fontFn(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DC.fontScale)
    }

    private enum DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGameViewModel()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portraitUpsideDown)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
    }
}
