//
//  String-Scoring.swift
//  Joggle
//
//  Created by Robert Martinez on 9/1/23.
//

import Foundation

extension String {
    var score: Int {
        if count < 5 {
            return 1
        } else {
            return count - 3
        }
    }
}
