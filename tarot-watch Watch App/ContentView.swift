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
                    .rotationEffect(.degrees(card.isReversed ? 180 : 0))
                Text("\(card.name)")
                Text(card.isReversed ? "逆位置" : "正位置")
                    .font(.subheadline)
                    .foregroundColor(card.isReversed ? .red : .green)
                Text("\(card.description)").font(.system(size: 12))
                Button(action: { selectedCard = nil }) {
                    Text("シャッフル")
                }
            } else {
                GridView(Array(0..<tarotDeck.cards.count)) { index in
                    Button(action: { selectedCard = tarotDeck.cards[index] }) {
                        Text("🎴")
                    }
                    .frame(width: 40, height: 30)

                    if index == 2 {
                        Spacer()
                    } else if index == 21 {
                        Button(action: { tarotDeck = TarotDeck() }) {
                            Text("🔄") // Shuffle emoji
                        }
                        .frame(width: 40, height: 30)
                    }
                }
            }
        }
        .onChange(of: selectedCard) { value in
            if value == nil {
                tarotDeck = TarotDeck()
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
        let descriptions = [
            "新たな始まり,自由,無知,純粋,冒険",
            "創造,意志力,技術,変化,自己表現",
            "神秘,直感,内面の声,知識,理解",
            "豊穣,母性,豊饒,自然,創造",
            "権威,父性,制御,組織,指導",
            "知恵,精神的な指導,教訓,共感,宗教",
            "愛,パートナーシップ,結合,統一,選択",
            "決定,勝利,自己制御,勇気,行動",
            "勇気,自制心,恐れの克服,決定力,内なる力",
            "内省,独りでいる,自己探求,思考,啓示",
            "運命,変化,チャンス,幸運,サイクル",
            "公平,バランス,正義,理性,真実",
            "犠牲,放棄,新たな視点,内面の検索,静止",
            "変化,終わり,新たな始まり,変換,再生",
            "バランス,調和,節制,統合,モデレーション",
            "誘惑,束縛,恐怖,欲望,失敗",
            "破壊,カオス,解放,変化,意外な出来事",
            "希望,信念,導き,啓示,平和",
            "恐怖,混乱,幻想,無知,誤解",
            "喜び,成功,満足,幸せ,達成",
            "再生,復活,醒め,審判,変化",
            "完結,達成,旅の終わり,新たなサイクル,完成"
        ]
        let reversedDescriptions = [
            "不確実性,不注意,危険,思慮不足,失敗",
            "欺瞞,混乱,無計画,未熟,潜在的才能",
            "秘密,過保護,未発達の才能,曖昧さ,混乱",
            "過保護,支配的,欠乏,過剰,依存",
            "頑固,権力闘争,非効率,不公平,不調和",
            "不寛容,狭量,信頼の欠如,悪徳,偽善",
            "不一致,不信,不調和,失恋,対立",
            "矛盾,誤解,不決定,負け,暴力",
            "虐待,弱さ,無力感,不調和,自己疑い",
            "孤立,隠蔽,秘密,恐れ,過度の孤独",
            "悪運,抵抗,不運,変化への抵抗,予想外の出来事",
            "不公平,偏見,虐待,不調和,矛盾",
            "抵抗,物事の先延ばし,怠け者,停滞,無駄な犠牲",
            "恐怖,固執,拒否,内なる抵抗,再生への抵抗",
            "不均衡,不調和,行き過ぎ,極端な行動,衝突",
            "制御,逃避,依存,自己破壊,束縛",
            "抵抗,無力感,危機,恐怖,否定的変化",
            "絶望,喪失,過度の楽観,落胆,破滅的思考",
            "不信,不確実,恐怖,誤解,混乱",
            "落胆,失望,過度の楽観,満足感の欠如,未達成",
            "否定,遅れ,抵抗,自己否定,未解決",
            "未完成,遅延,無計画,欠乏,目標未達成"
        ]
        let emojis = ["🏃", "🎩", "🌛", "👸", "👑", "🙏", "💑", "🏇", "💪", "🧙‍♂️", "🎡", "⚖️", "🙃", "☠️", "🚰", "😈", "⚡", "🌟", "🌝", "🌞", "👼", "🌎"]
        var shuffledIndexes = Array(0..<22).shuffled()
        for _ in 0..<22 {
            let index = shuffledIndexes.removeLast()
            let isReversed = Bool.random()
            let cardDescription = isReversed ? reversedDescriptions[index] : descriptions[index]
            let card = TarotCard(name: names[index], description: cardDescription, emoji: emojis[index], isReversed: isReversed)
            cards.append(card)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
