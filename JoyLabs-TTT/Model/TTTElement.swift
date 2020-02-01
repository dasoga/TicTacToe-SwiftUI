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
    case P1, P2
    
    var title: String {
        switch self {
        case .P1:
            return "Player 1"
        case .P2:
            return "Player 2"
        }
    }
}

class TTTElement: ObservableObject {
    let id = UUID()
    @Published var status: TTTElementStatus = .none
    var selected = false
}


class Game {
    var elements = [TTTElement]()
    
    init(){
        for _ in 0...8 {
            self.elements.append(TTTElement())
        }
    }
     
    func changeStatus(_ index: Int, currentPlayer: TTTPlayer){
        let currentElement = elements[index]
        if !currentElement.selected{
            if currentPlayer == .P1{
                elements[index].status = .x
            }else{
                elements[index].status = .o
            }
            elements[index].selected = true
        }
    }
    
    func resetGame(){
        for i in 0...8 {
            elements[i].status = .none
            elements[i].selected = false
        }
    }
}
