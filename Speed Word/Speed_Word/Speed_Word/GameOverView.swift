//
//  GameOverView.swift
//  Speed_Word
//
//  Created by LOTI Didier on 17/10/2024.
//

import SwiftUI

struct GameOverView: View {
    var score: Int
    var onRestart: () -> Void
    var onQuit: () -> Void

    var body: some View {
        VStack {
            Text("Game Over")
                .font(.largeTitle)
                .padding()
            
            Text("Your Score: \(score)")
                .font(.title)
                .padding()
            
            Button(action: onRestart) {
                Text("Restart")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            
            NavigationLink(destination: MainView()){
                Text("Quit")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 10)
        }
        .padding()
    }
}
