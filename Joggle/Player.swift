//
//  Player.swift
//  Joggle
//
//  Created by Robert Martinez on 7/9/23.
//

import SwiftUI

class Player: ObservableObject {
    var usedWords = [String]()
    var color: Color
    
    @Published var selectedTiles = [Int]()
    
    init(color: Color) {
    self.color = color
    }
    
    func reset() {
        selectedTiles.removeAll()
        usedWords.removeAll()
    }
    
    func trySelecting(_ index: Int, in game: Game) -> String? {
        if selectedTiles.last == index && selectedTiles.count >= 3 {
            return submit(in: game)
        }
        
        if let indexLocation = selectedTiles.firstIndex(of: index) {
            if selectedTiles.count == 1 {
                selectedTiles.removeLast()
            } else {
                selectedTiles.removeLast(selectedTiles.count - indexLocation - 1)
            }
        } else {
            tryAppending(index)
        }
        
        return nil
    }
    
    func tryAppending(_ newIndex: Int) {
        guard let lastIndex = selectedTiles.last else {
            selectedTiles.append(newIndex)
            return
        }
        
        let lastPosition = (row: lastIndex / 4, col: lastIndex % 4)
        let newPosition = (row: newIndex / 4, col: newIndex % 4)
        let positionDifference = (row: abs(newPosition.row - lastPosition.row), col: abs(newPosition.col - lastPosition.col))
        
        if max(positionDifference.row, positionDifference.col) == 1 {
            selectedTiles.append(newIndex)
        }
    }
    
    func submit(in game: Game) -> String? {
        let word = selectedTiles.map { game.tiles[$0] }.joined().lowercased()
        
        guard usedWords.contains(word) == false else {
            return "You used that word already."
        }
        
        if Dictionary.contains(word) {
            usedWords.append(word)
            game.add(word, for: self)
            selectedTiles.removeAll()
        } else {
            return "That isn't a valid word."
        }
        return nil
    }
}
