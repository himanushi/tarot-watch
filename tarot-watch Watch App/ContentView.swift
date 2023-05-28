//
//  ContentView.swift
//  tarot-watch Watch App
//
//  Created by 匿名 on 2023/05/28.
//

import SwiftUI

struct ContentView: View {
    
    @State var tarotDeck = TarotDeck()
    @State var selectedCard: TarotCard?
    
    var body: some View {
        VStack {
            if let card = selectedCard {
                Text("\(card.emoji) \(card.name) - \(card.description)")
                Text(card.isReversed ? "Reversed" : "Upright")
                    .font(.subheadline)
                    .foregroundColor(card.isReversed ? .red : .green)
                Button(action: { selectedCard = nil }) {
                    Text("Back to deck")
                }
            } else {
                GridView(Array(tarotDeck.cards.indices)) { index in
                    Button(action: { selectedCard = tarotDeck.cards[index] }) {
                        Text("🎴")
                    }
                    .frame(width: 30, height: 30)
                }
            }
        }
        .onChange(of: selectedCard) { value in
            if value == nil {
                tarotDeck = TarotDeck() // Reshuffle the deck when back to deck
            }
        }
    }
}

struct GridView<Content: View, ID: Hashable>: View {
    let data: [ID]
    let content: (ID) -> Content

    init(_ data: [ID], @ViewBuilder content: @escaping (ID) -> Content) {
        self.data = data
        self.content = content
    }

    var body: some View {
        let columns: [GridItem] = [.init(.flexible()), .init(.flexible()), .init(.flexible()), .init(.flexible())]
        LazyVGrid(columns: columns, content: {
            ForEach(data, id: \.self) { id in
                content(id)
            }
        })
    }
}

struct TarotCard: Equatable {
    var name: String
    var description: String
    var emoji: String  // Add emoji property
    var isReversed: Bool
}

struct TarotDeck {
    var cards: [TarotCard] = []
    init() {
        let names = ["The Fool", "The Magician", "The High Priestess", "The Empress", "The Emperor", "The Hierophant", "The Lovers", "The Chariot", "Strength", "The Hermit", "Wheel of Fortune", "Justice", "The Hanged Man", "Death", "Temperance", "The Devil", "The Tower", "The Star", "The Moon", "The Sun", "Judgement", "The World"]
        let descriptions = ["A new beginning", "Power of manifestation", "Mystery", "Abundance", "Authority", "Wisdom", "Love", "Determination", "Courage", "Introspection", "Luck", "Fairness", "Sacrifice", "Change", "Balance", "Temptation", "Destruction", "Hope", "Fear", "Joy", "Rebirth", "Completion"]
        let emojis = ["🤡", "🎩", "🌛", "👸", "👑", "🙏", "💑", "🏇", "💪", "🧙‍♂️", "🎡", "⚖️", "🙃", "☠️", "⚗️", "😈", "🏰", "🌟", "🌚", "🌞", "👼", "🌎"] // Add emojis
        var shuffledIndexes = Array(0..<22).shuffled()
        for _ in 0..<22 {
            let index = shuffledIndexes.removeLast()
            let isReversed = Bool.random()
            let card = TarotCard(name: names[index], description: descriptions[index], emoji: emojis[index], isReversed: isReversed)
            cards.append(card)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
