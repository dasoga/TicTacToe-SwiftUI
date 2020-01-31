//
//  ContentView.swift
//  JoyLabs-TTT
//
//  Created by Dante Solorio on 29/01/20.
//  Copyright © 2020 Joy Labs. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let buttons = [
        ["", "X", "X"],
        ["X", "X", "X"],
        ["X", "X", "X"]
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack (spacing: 12) {
                    ForEach(buttons, id: \.self) { row in
                        HStack (spacing: 12) {
                            ForEach(row, id: \.self) { button in
                                Text(button)
                                    .font(.largeTitle)
                                    .frame(width: self.buttonWidth(), height: self.buttonWidth())
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func buttonWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - 4 * 12) / 3
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
