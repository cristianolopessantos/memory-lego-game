//
//  LegoMemoryGameView.swift
//  Lego
//
//  Created by Cristiano  Santos on 07/06/22.
//

import SwiftUI

 struct LegoMemoryGameView: View {
    
@ObservedObject var game: LegoMemoryGame
    

var body: some View {

    
        LazyVGrid(columns: [GridItem(.adaptive(minimum:88))]){
            ForEach(game.cards) { card in
                CardView(card: card, danger: game.isThereDanger())
                    .aspectRatio(2/3, contentMode: .fit)
                    .onTapGesture{
                        game.choose(card)
                    }
                }
            }
        .font(.title)
        .padding(.horizontal)
        .foregroundColor(.indigo)
    
    }
}

struct CardView: View {
    let card: LegoMemoryGame.Card
    let danger: Bool
//    static let gradientStart = Color(red: 0.0 / 255, green: 130.0 / 255, blue: 193.0 / 255)
//    static let gradientEnd =
    var body: some View {
        let gradientStart = danger ? Color(red: 235 / 255, green: 18 / 255, blue: 100 / 255) : Color(red: 0.0 / 255, green: 130.0 / 255, blue: 193.0 / 255)
        let gradientEnd = danger ? Color(red: 203 / 255, green: 26 / 255, blue: 36 / 255) : Color(red: 0.0 / 255, green: 192.0 / 255, blue: 197.0 / 255)
        ZStack {
            let shape = RoundedRectangle(cornerRadius:10)
            let gradient_shape = LinearGradient(
            gradient: .init(colors: [gradientStart, gradientEnd]),
            startPoint: .init(x: 0.5, y: 0),
            endPoint: .init(x: 0.5, y: 0.6)
          )
        
            if card.isFaceUp {
                shape
                    .fill(.white)
                shape
                    .strokeBorder(lineWidth: 2)
                    .foregroundColor(.indigo)
                Image(card.content)
                    .resizable()
                    .scaledToFit()
            } else if card.isMatched{
                shape.opacity(0)
            } else {
                shape
                    .fill(gradient_shape)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
static var previews: some View {
    let game = LegoMemoryGame()
    LegoMemoryGameView(game: game)
    }
}
