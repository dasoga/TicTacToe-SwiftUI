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
    @State private var initialGame = true
    @State private var showAlert = true
    @State private var disableResetButton = true
    @State var gameMode = GameMode.OnePlayer
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    Button(action: {
                        self.resetGamePressed()
                    }) {
                        Image(systemName: "arrow.2.circlepath")
                            .resizable()
                            .frame(width: 40, height: 35)
                    }.disabled(disableResetButton)
                    Text("Reset")
                        .font(.caption)
                        .foregroundColor(.blue)
                    
                    Spacer()
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: UIScreen.main.bounds.height / 4, alignment: .trailing)
                
                VStack (spacing: 12) {
                    VStack (alignment: .leading, spacing: 10) {
                        Text(currentPlayer.title)
                            .foregroundColor(.white)
                            .font(.largeTitle)
                        Divider()
                    }.padding(.horizontal, 12)
                    
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
                .alert(isPresented: $showAlert) {
                    if gameOver {
                        return Alert(title: Text((self.gameElements.gameOver.1 == .none) ? "Game Over" : "Winner"), message: Text((self.gameElements.gameOver.1 != .none) ? ((self.gameElements.gameOver.1 == .x) ? "Player 1 won" : "Player 2 won") : "Draw"), dismissButton: .default(Text("OK")){
                            self.resetGamePressed()
                            })
                    }
                    
                    
                    return Alert(title: Text("Play as:"), message: Text(""), primaryButton: .default(Text("One player")){
                        self.configureGameAsOnePlayer()
                        }, secondaryButton: .default(Text("Two players")){
                            self.configureGameAsTwoPlayers()
                        })
                    
                }
                
                Spacer()
                
                VStack (alignment: .trailing){
                    Text("Powered by Joy Labs")
                        .foregroundColor(.gray)
                        .font(.footnote)
                }
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
    }
    
    
    private func cellPressed(_ index: Int) {
        gameElements.changeStatus(index, currentPlayer: currentPlayer)
        currentPlayer = gameElements.gameCurrentPlayer
        gameOver = gameElements.gameOver.0
        gameMode = gameElements.gameMode
        showAlert = gameOver
        if disableResetButton {
            disableResetButton = false
        }
    }
    
    private func resetGamePressed() {
        self.currentPlayer = .P1
        self.gameElements.resetGame()
        initialGame = true
        showAlert = initialGame
        disableResetButton = true
    }

    private func configureGameAsOnePlayer() {
        gameElements.gameMode = .OnePlayer
    }
    
    private func configureGameAsTwoPlayers() {
        gameElements.gameMode = .TwoPlayers
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
                .background(element.winner ? Color.green : Color.blue)
            
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
