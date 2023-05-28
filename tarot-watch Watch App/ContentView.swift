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
                Text("\(card.emoji)")
                    .font(.largeTitle)
                Text("\(card.name)")
                Text(card.isReversed ? "逆位置" : "正位置")
                    .font(.subheadline)
                    .foregroundColor(card.isReversed ? .red : .green)
                Text("\(card.description)")
                Button(action: { selectedCard = nil }) {
                    Text("デッキに戻る")
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
        let names = ["愚者", "魔術師", "女教皇", "女帝", "皇帝", "教皇", "恋人", "戦車", "力", "隠者", "運命の輪", "正義", "吊された男", "死神", "節制", "悪魔", "塔", "星", "月", "太陽", "審判", "世界"]
        let descriptions = ["新たな始まり", "実現の力", "神秘", "豊穣", "権威", "知恵", "愛", "決定", "勇気", "内省", "運命", "公平", "犠牲", "変化", "バランス", "誘惑", "破壊", "希望", "恐怖", "喜び", "再生", "完結"]
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
