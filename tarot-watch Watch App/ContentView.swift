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
               "新たな始まり,自由,無知,純粋,冒険,信頼,大胆,楽観,直感,無垢",
               "創造,意志力,技術,変化,自己表現,戦略,自己信頼,可能性,手練手管,知識",
               "神秘,直感,内面の声,知識,理解,内省,調和,包含,母性,成長",
               "豊穣,母性,豊饒,自然,創造,繁栄,美,安心,愛情,調和",
               "権威,父性,制御,組織,指導,保護,堅固,勇敢,責任,力",
               "知恵,精神的な指導,教訓,共感,宗教,啓示,教義,倫理,説明,信念",
               "愛,パートナーシップ,結合,統一,選択,信頼,恋愛,結婚,調和,契約",
               "決定,勝利,自己制御,勇気,行動,向上心,忍耐,闘争,勝利,進行",
               "勇気,自制心,恐れの克服,決定力,内なる力,パワー,堅実,達成,バランス,エネルギー",
               "内省,独りでいる,自己探求,思考,啓示,内面の声,慎重,瞑想,成熟,静寂",
               "運命,変化,チャンス,幸運,サイクル,可能性,期待,予見,リスク,チャレンジ",
               "公平,バランス,正義,理性,真実,倫理,法,規則,平等,公正",
               "犠牲,放棄,新たな視点,内面の検索,静止,反抗,逆転,悔い改め,魂の試練,内面の闘い",
               "変化,終わり,新たな始まり,変換,再生,転換,終焉,新生,開放,変貌",
               "バランス,調和,節制,統合,モデレーション,繁栄,創造,幸福,調整,自制",
               "誘惑,束縛,恐怖,欲望,失敗,陰鬱,嘲笑,破壊,衝動,困難",
               "破壊,カオス,解放,変化,意外な出来事,衝撃,困難,リスク,危機,進展",
               "希望,信念,導き,啓示,平和,前進,新たな目標,明確,安心,平和",
               "恐怖,混乱,幻想,無知,誤解,不安,変容,幻滅,謎,夢",
               "喜び,成功,満足,幸せ,達成,輝き,自慢,善意,誠実,繁栄",
               "再生,復活,醒め,審判,変化,進化,新生,希望,更新,悔い改め",
               "完結,達成,旅の終わり,新たなサイクル,完成,成功,達成,理解,調和,完全"
           ]

           let reversedDescriptions = [
               "不確実性,不注意,危険,思慮不足,失敗,過信,落胆,混乱,無計画,機会損失",
               "欺瞞,混乱,無計画,未熟,潜在的才能,迷信,欠乏,無能,制約,自己中心",
               "秘密,過保護,未発達の才能,曖昧さ,混乱,無知,隠蔽,誤解,混乱,偽り",
               "過保護,支配的,欠乏,過剰,依存,無気力,抑圧,不満,退廃,逆境",
               "頑固,権力闘争,非効率,不公平,不調和,専横,独裁,破壊,抑圧,過度",
               "不寛容,狭量,信頼の欠如,悪徳,偽善,権威主義,無知,固執,退廃,尊大",
               "不一致,不信,不調和,失恋,対立,遠慮,冷淡,浮気,不安,反抗",
               "矛盾,誤解,不決定,負け,暴力,逃走,怠惰,逆転,軽率,非協力",
               "虐待,弱さ,無力感,不調和,自己疑い,悲観,失望,絶望,失敗,否定",
               "孤立,隠蔽,秘密,恐れ,過度の孤独,疎外感,無視,孤独,無関心,忍耐",
               "悪運,抵抗,不運,変化への抵抗,予想外の出来事,困難,挫折,失敗,危機,退行",
               "不公平,偏見,虐待,不調和,矛盾,不公正,腐敗,失敗,欠乏,法律違反",
               "抵抗,物事の先延ばし,怠け者,停滞,無駄な犠牲,遅滞,後悔,逆境,拒絶,無気力",
               "恐怖,固執,拒否,内なる抵抗,再生への抵抗,逆転,遅滞,反抗,暴動,損失",
               "不均衡,不調和,行き過ぎ,極端な行動,衝突,混乱,困難,ストレス,過負荷,不調",
               "制御,逃避,依存,自己破壊,束縛,操られ,嘘,陰鬱,欺瞞,誤解",
               "抵抗,無力感,危機,恐怖,否定的変化,衝撃,逆転,不安,悲観,破壊",
               "絶望,喪失,過度の楽観,落胆,破滅的思考,無力感,失望,悲観,不安,迷走",
               "混乱,欺瞞,虚偽,不確実性,夢想,迷信,幻覚,騙し,欺瞞,不安",
               "落胆,失敗,欺瞞,未達成,虚偽,裏切り,虚栄心,無関心,損失,過大評価",
               "恐怖,否定,拒否,失敗,退行,後悔,判断の誤り,不適,罪悪感,苦悩",
               "未完,失敗,進行の遅延,目標の欠如,停滞,遅滞,遅れ,困難,満足のいかない結果,不安定"
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
