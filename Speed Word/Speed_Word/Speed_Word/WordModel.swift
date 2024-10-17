//
//  WordModel.swift
//  Speed_Word
//
//  Created by LOTI Didier on 17/10/2024.
//

import Foundation

class WordModel: ObservableObject {
    @Published var words: [String] = []
    @Published var score: Int = 0
    @Published var currentWordIndex: Int = 0
    @Published var timeRemaining: Int = 120
    @Published var isActive: Bool = false
    @Published var isGameOver: Bool = false

    func startGame() {
        score = 0
        timeRemaining = 10
        isActive = true
        isGameOver = false
        currentWordIndex = 0
        fetchWords()
    }

    func endGame() {
        isActive = false
        isGameOver = true
    }

    func validateWord(_ inputWord: String) {
        if inputWord.lowercased() == words[currentWordIndex].lowercased() {
            score += 1
            currentWordIndex += 1
        }
        if currentWordIndex >= words.count {
            endGame()
        }
    }

    func fetchWords() {
        guard let url = URL(string: "https://random-word-api.herokuapp.com/word?number=200") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let fetchedWords = try? JSONDecoder().decode([String].self, from: data) {
                    DispatchQueue.main.async {
                        self.words = fetchedWords
                    }
                }
            }
        }.resume()
    }
}

