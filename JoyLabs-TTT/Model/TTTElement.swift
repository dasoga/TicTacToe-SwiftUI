//
//  TTTElement.swift
//  JoyLabs-TTT
//
//  Created by Dante Solorio on 30/01/20.
//  Copyright © 2020 Joy Labs. All rights reserved.
//

import SwiftUI
import Combine

enum TTTElementStatus {
    case none, x, o
    
    var title: String {
        switch self {
        case .none:
            return ""
        case .x:
            return "X"
        case .o:
            return "O"
        }
    }
}

enum TTTPlayer {
    case P1, P2, AI
    
    var title: String {
        switch self {
        case .P1:
            return "Player 1"
        case .P2:
            return "Player 2"
        case .AI:
            return "AI"
        }
    }
}

enum GameMode {
    case OnePlayer, TwoPlayers
}

class TTTElement: ObservableObject {
    let id = UUID()
    @Published var status: TTTElementStatus = .none
    var selected = false
    var winner = false
}


class Game {
    var elements = [TTTElement]()
    @Published var gameCurrentPlayer = TTTPlayer.P1
    @Published var gameMode = GameMode.OnePlayer
    
    var gameOver: (Bool, TTTElementStatus) {
        get {
            if winner().0 {
                return (true, winner().1)
            }else if allCellsSelected() {
                return (true, .none)
            }
            return (false, .none)
        }
    }
    
    init(){
        for _ in 0...8 {
            self.elements.append(TTTElement())
        }
    }
    
    func changeStatus(_ index: Int, currentPlayer: TTTPlayer) {
        let currentElement = elements[index]
        if !currentElement.selected{
            elements[index].selected = true
            if gameMode == .OnePlayer {
                if currentPlayer == .P1 {
                    elements[index].status = .x
                    self.aiMove()
                }
            } else{
                if currentPlayer == .P1{
                    elements[index].status = .x
                }else{
                    elements[index].status = .o
                }
                gameCurrentPlayer = currentPlayer == .P1 ? .P2 : .P1
            }
        }
    }
    
    private func aiMove() {
        var emptyElements: [TTTElement] = []
        for element in elements {
            if !element.selected {
                emptyElements.append(element)
            }
        }
        
        if let element = emptyElements.randomElement() {
            element.status = .o
            element.selected = true
        }
    }
    
    func resetGame(){
        for element in elements{
            element.status = .none
            element.selected = false
            element.winner = false
        }
        gameCurrentPlayer = .P1
    }
    
    private func allCellsSelected() -> Bool {
        let elementsFiltered = elements.filter({ $0.status == .none })
        if elementsFiltered.count == 0 {
            return true
        }
        
        return false
    }
    
    private func winner() -> (Bool, TTTElementStatus) {
        let (completed, status) = combinationCompleted()
        if completed {
            return (true, status)
        }
        return (false, .none)
    }
    
    private func combinationCompleted() -> (Bool, TTTElementStatus) {
        let elementsX = elements.filter({ $0.status == .x })
        let elementsO = elements.filter({ $0.status == .o })
        
        if elementsX.count >= 3 {
            if validateCombination(status: .x) {
                return (true, .x)
            }
        }
        
        if elementsO.count >= 3 {
            if validateCombination(status: .o) {
                return (true, .o)
            }
        }
        
        return (false, .none)
    }
    
    private func validateCombination(status: TTTElementStatus) -> Bool{
        let options = [
            [0,1,2],
            [3,4,5],
            [6,7,8],
            [0,3,6],
            [1,4,7],
            [2,5,8],
            [0,4,8],
            [2,4,6],
        ]
        var count: Int = 0
        var winnerCombination: [Int] = []
        for option in options {
            for winIndex in option {
                if elements[winIndex].status == status {
                    count += 1
                    winnerCombination.append(winIndex)
                    if count == 3 {
                        winnersBackground(winnerCombination)
                        return true
                    }
                }
            }
            count = 0
            winnerCombination = []
        }
        
        return false
    }
    
    private func winnersBackground (_ winnerCombination: [Int]) {
        for winner in winnerCombination {
            elements[winner].winner = true
        }
    }
}
