//
//  MemoryGame.swift
//  Lego
//
//  Created by Cristiano  Santos on 15/06/22.
//
import UIKit
import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private let soundsSuccessArray = ["acerto-mizeravi", "certa-resposta"]
    private let soundsErrorArray = ["faustao-errou", "ih-rapaz"]
    private let hapticFeedback = UINotificationFeedbackGenerator()
    private(set)var cards: Array<Card>
    var countAttemps: Int = 0
    let limitAttempts: Int = 50
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        if let chooseIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[chooseIndex].isFaceUp,
           !cards[chooseIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
//                let randomInt = Int.random(in: 0...1)
                if cards[chooseIndex].content == cards[potentialMatchIndex].content {
                    cards[chooseIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    hapticFeedback.notificationOccurred(.success)
//                    playSound(sound: soundsSuccessArray[randomInt], type: "mp3")
                }else{
                    hapticFeedback.notificationOccurred(.error)
//                    playSound(sound: soundsErrorArray[randomInt], type: "mp3")
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
                countAttemps+=1
            }else{
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chooseIndex
            }
            
            cards[chooseIndex].isFaceUp.toggle()
        }
    }
    
    
    func index(of card:Card) -> Int? {
        
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    }
    
    init(numberOfPairOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // add numberOfPairOfCards x 2 cards to cards array
        for pairIndex in 0..<numberOfPairOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable{
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
