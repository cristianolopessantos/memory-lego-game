//
//  LegoMemoryGame.swift
//  Memoize
//
//  Created by Cristiano  Santos on 15/06/22.
//

import SwiftUI

class LegoMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private var danger: Int = 0
    private var total: Double = 0
    private static let legos = ["thumb-shadow", "thumb-supersonic", "thumb-sonic-metal", "thumb-robotinic", "thumb-sonica", "thumb-sonico2", "thumb-sonico", "thumb-tails", "thumb-esmeralda", "thumb-sonic-branco", "thumb-todo-mundo", "thumb-logo", "thumb-sonic-vermelho"]
//    static let legosPrincesas = ["thumb-anao5", "thumb-anao4", "thumb-anao3", "thumb-anao2", "thumb-anao1", "thumb-tiana", "thumb-ruiva", "thumb-rapunzel", "thumb-cinderella", "thumb-jasmine-burrico", "thumb-ariel-mar", "thumb-ariel", "thumb-princesa-rosa", "thumb-todas-princesas", "thumb-princesa-amarela", "thumb-elsa-ana", "thumb-snow-white", "thumb-jasmine", "thumb-ana", "thumb-elsa"]
//    static let legos = ["thumb-alerquina", "thumb-aligator", "thumb-all", "thumb-alladin", "thumb-american", "thumb-aquaman", "thumb-auditor", "thumb-batman", "thumb-bolo", "thumb-cachorro", "thumb-construtor", "thumb-coringa","thumb-corre", "thumb-deadpool", "thumb-flash", "thumb-games", "thumb-heroes",  "thumb-hulk", "thumb-iron",  "thumb-joker", "thumb-jupiter", "thumb-leya", "thumb-lutador", "thumb-malhar", "thumb-ninja", "thumb-ninjinha", "thumb-padeiro","thumb-ped reiro", "thumb-pesquisador",  "thumb-pintor", "thumb-pretao", "thumb-rayden", "thumb-robin", "thumb-rock","thumb-rosa","thumb-spider", "thumb-superman", "thumb-surf", "thumb-tim", "thumb-verdao","thumb-vermelhao", "thumb-vision", "thumb-viuva", "thumb-wolwevine", "thumb-wonderwoman", "thumb-ze1", "thumb-ze2", "thumb-ze3", "thumb-ze4", "thumb-ze5"];
    static let shuffledCards = legos.shuffled()
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairOfCards: 12) {pairIndex in
            shuffledCards[pairIndex]
            }
    }
     
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<Card> {
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
    
    func choose(_ card: Card){
        model.choose(card)
    }
}
