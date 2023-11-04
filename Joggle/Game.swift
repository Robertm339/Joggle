//
//  Game.swift
//  Joggle
//
//  Created by Robert Martinez on 7/9/23.
//

import Combine
import Foundation

class Game: ObservableObject {
    var scores = [String: Player]()
    
    var dice = [
        ["A", "A", "E", "E", "G", "N"],
        ["A", "B", "B", "J", "O", "O"],
        ["A", "C", "H", "O", "P", "S"],
        ["A", "F", "F", "K", "P", "S"],
        ["A", "O", "O", "T", "T", "W"],
        ["C", "I", "M", "O", "T", "U"],
        ["D", "E", "I", "L", "R", "X"],
        ["D", "E", "L", "R", "V", "Y"],
        ["D", "I", "S", "T", "T", "Y"],
        ["E", "E", "G", "H", "N", "W"],
        ["E", "E", "I", "N", "S", "U"],
        ["E", "H", "R", "T", "V", "W"],
        ["E", "I", "O", "S", "S", "T"],
        ["E", "L", "R", "T", "T", "Y"],
        ["H", "L", "N", "N", "R", "Z"],
        ["H", "I", "M", "N", "U", "Qu"]
    ]
    
    var player1 = Player(color: .mint)
    var player2 = Player(color: .orange)
    var tiles = [String]()
    
    @Published var timeRemaining = 0.0
    @Published var showingResults = false
    private var timer: AnyCancellable?
    
    init() {
        reset()
    }
    
    func reset() {
        tiles = dice.shuffled().map {
            $0.randomElement() ?? "X"
        }
        
        scores.removeAll()
        player1.reset()
        player2.reset()
        
        timer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: update)
        
        timeRemaining = 180
    }
    
    func update(_ newTime: Date) {
        guard showingResults == false else { return }
        
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            showingResults = true
        }
    }
    
    func add(_ word: String, for player: Player) {
        if scores[word] == nil {
            scores[word] = player
        }
    }
}
