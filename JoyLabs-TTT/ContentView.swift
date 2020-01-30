//
//  ContentView.swift
//  JoyLabs-TTT
//
//  Created by Dante Solorio on 29/01/20.
//  Copyright © 2020 Joy Labs. All rights reserved.
//

import SwiftUI

enum tttElementStatus {
    case nonoe
    case x
    case o
}

struct tttElementView: View {
    var value = "O"
    var body: some View {
        Button("--") {
            print("O")
        }
        .font(.largeTitle)
        .background(Color.gray)
        .padding()
    }
}

struct tttRowElementsView: View {
    var body: some View {
        HStack {
            tttElementView()
            Divider()
            tttElementView()
            Divider()
            tttElementView()
        }
    }
}

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Restart") {
                    print("restarting...")
                }
                VStack {
                    tttRowElementsView()
                    Divider()
                    tttRowElementsView()
                    Divider()
                    tttRowElementsView()
                }
            }
            .navigationBarTitle("Tic Tac Toe")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
