//
//  ContentView.swift
//  JoyLabs-TTT
//
//  Created by Dante Solorio on 29/01/20.
//  Copyright © 2020 Joy Labs. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    private var gameElements = Game()
    @State var currentPlayer = TTTPlayer.P1
    @State private var gameOver = false
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack (spacing: 12) {
                
                Button(action: {
                    self.gameElements.resetGame()
                }) {
                    Text("Reset Game")
                        .font(.largeTitle)
                }
                
                HStack {
                    TTTCell(element: gameElements.elements[0]) {
                        self.cellPressed(0)
                    }
                    TTTCell(element: gameElements.elements[1]) {
                        self.cellPressed(1)
                    }
                    TTTCell(element: gameElements.elements[2]) {
                        self.cellPressed(2)
                    }
                }
                HStack {
                    TTTCell(element: gameElements.elements[3]) {
                        self.cellPressed(3)
                    }
                    TTTCell(element: gameElements.elements[4]) {
                        self.cellPressed(4)
                    }
                    TTTCell(element: gameElements.elements[5]) {
                        self.cellPressed(5)
                    }
                }
                HStack {
                    TTTCell(element: gameElements.elements[6]) {
                        self.cellPressed(6)
                    }
                    TTTCell(element: gameElements.elements[7]) {
                        self.cellPressed(7)
                    }
                    TTTCell(element: gameElements.elements[8]) {
                        self.cellPressed(8)
                    }
                }
            }
            .alert(isPresented: $gameOver) {
                Alert(title: Text((self.gameElements.gameOver.1 == .none) ? "Game Over" : "Winner"), message: Text((self.gameElements.gameOver.1 != .none) ? ((self.gameElements.gameOver.1 == .x) ? "Player 1 won" : "Player 2 won") : "Draw"), dismissButton: .default(Text("OK")){
                    self.currentPlayer = .P1
                    self.gameElements.resetGame()
                })
            }
        }
    }

    
    private func cellPressed(_ index: Int) {
        gameElements.changeStatus(index, currentPlayer: currentPlayer)
        currentPlayer = gameElements.gameCurrentPlayer
        gameOver = gameElements.gameOver.0
    }
}

struct TTTCell: View {
    
    @ObservedObject var element: TTTElement
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            Text(element.status.title)
                .font(.largeTitle)
                .frame(width: self.buttonWidth(), height: self.buttonWidth())
                .foregroundColor(.white)
                .background(Color.blue)
            
        }
    }
    
    private func buttonWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - 4 * 12) / 3
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
