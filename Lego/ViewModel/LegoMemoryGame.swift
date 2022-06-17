//
//  LegoMemoryGame.swift
//  Memoize
//
//  Created by Cristiano  Santos on 15/06/22.
//

import SwiftUI

class LegoMemoryGame: ObservableObject {
    private var danger: Int = 0
    private var total: Double = 0
    static let legos = ["thumb-alerquina", "thumb-aligator", "thumb-all", "thumb-alladin", "thumb-american", "thumb-aquaman", "thumb-auditor", "thumb-batman", "thumb-bolo", "thumb-cachorro", "thumb-construtor", "thumb-coringa","thumb-corre", "thumb-deadpool", "thumb-flash", "thumb-games", "thumb-heroes",  "thumb-hulk", "thumb-iron",  "thumb-joker", "thumb-jupiter", "thumb-leya", "thumb-lutador", "thumb-malhar", "thumb-ninja", "thumb-ninjinha", "thumb-padeiro","thumb-pedreiro", "thumb-pesquisador",  "thumb-pintor", "thumb-pretao", "thumb-rayden", "thumb-robin", "thumb-rock","thumb-rosa", "thumb-sonic",
                            "thumb-spider", "thumb-superman", "thumb-surf", "thumb-tim", "thumb-verdao","thumb-vermelhao", "thumb-vision", "thumb-viuva", "thumb-wolwevine", "thumb-wonderwoman", "thumb-ze1", "thumb-ze2", "thumb-ze3", "thumb-ze4", "thumb-ze5"];
        
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairOfCards: 27) {pairIndex in
                legos[pairIndex]
            }
    }
     
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    func getCount() -> Int {
        return model.countAttemps
    }
    
    func isThereDanger() -> Bool {
        for index in model.cards.indices {
            if !model.cards[index].isMatched {
                danger += 1
            }
        }
        
        if (model.limitAttempts - model.countAttemps) <= model.limitAttempts/2 , danger > 10 {
            return true
        }
        return false
    }
    //MARK: -Intents
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
}
