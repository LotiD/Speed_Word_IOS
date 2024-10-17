//
//  WordGameView.swift
//  Speed_Word
//
//  Created by LOTI Didier on 17/10/2024.
//

import SwiftUI

struct WordGameView: View {
    @ObservedObject var model = WordModel()
    @State private var inputWord: String = ""
    @State private var timer: Timer? = nil

    var body: some View {
        NavigationView {
            ZStack {
                Image("bgImage")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                if model.isGameOver {
                    GameOverView(score: model.score, onRestart: restartGame, onQuit: quitGame)
                } else {
                    VStack {
                        Text("Score: \(model.score)")
                            .font(.largeTitle)
                            .padding()

                        Text("Time Remaining: \(timeFormatted(model.timeRemaining))")
                            .font(.title2)
                            .padding()

                        if model.isActive && model.currentWordIndex < model.words.count {
                            Text("Current Word: \(model.words[model.currentWordIndex])")
                                .font(.title)
                                .padding()
                        }

                        TextField("Enter the word", text: $inputWord)
                            .frame(width: 246, height: 44)
                            .background(Color("Transparent"))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .disabled(!model.isActive)

                        Button(action: {
                            model.validateWord(inputWord)
                            inputWord = ""
                        }) {
                            Text("Validate Word")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .disabled(!model.isActive || model.words.isEmpty)

                        Button(action: model.startGame) {
                            Text("Start Game")
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.top, 20)

                        Spacer()
                    }
                }
            }
            .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                if model.isActive {
                    if model.timeRemaining > 0 {
                        model.timeRemaining -= 1
                    } else {
                        model.endGame()
                    }
                }
            }
            .padding()
        }
    }

    private func timeFormatted(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func restartGame() {
        model.startGame()
    }

    private func quitGame() {
        // Logique pour quitter le jeu
    }
}

