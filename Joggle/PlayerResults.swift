//
//  PlayerResults.swift
//  Joggle
//
//  Created by Robert Martinez on 9/1/23.
//

import SwiftUI

struct PlayerResults: View {
    var number: Int
    var score: Int
    var words: [String]
    
    var body: some View {
        Section {
            if words.isEmpty {
                Text("None")
            } else {
                ForEach(words, id: \.self) { word in
                    Text("\(word) (\(word.score))")
                }
            }
        } header: {
            Text("Player \(number) score")
        } footer: {
            Text("Total: ^[\(score) points](inflect: true)")
        }
    }
}

#Preview {
    PlayerResults(number: 1, score: 4, words: ["the", "cat", "sat", "mat"])
}
