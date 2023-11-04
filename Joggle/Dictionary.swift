//
//  Dictionary.swift
//  Joggle
//
//  Created by Robert Martinez on 7/9/23.
//

import Foundation

enum Dictionary {
    private static let contents: Set<String> = {
        guard let url = Bundle.main.url(forResource: "dictionary", withExtension: "txt") else {
            fatalError("Cannot find dictionary.txt")
        }
        
        guard let contents = try? String(contentsOf: url) else {
            fatalError("Couldn't load dictionary.txt")
        }
        
        return Set(contents.components(separatedBy: .newlines))
    }()
    
    static func contains(_ word: String) -> Bool {
        contents.contains(word)
    }
}
