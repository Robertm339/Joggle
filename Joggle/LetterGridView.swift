//
//  LetterGridView.swift
//  Joggle
//
//  Created by Robert Martinez on 7/9/23.
//

import SwiftUI

struct LetterGridView: View {
    @ObservedObject var player: Player
    var game: Game
    
    var columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    @State private var message: String? 
    
    var body: some View {
        ZStack {
            LazyVGrid(columns: columns) {
                ForEach(0..<game.tiles.count, id: \.self) { index in
                    let tile = game.tiles[index]
                    
                    LetterView(letter: tile, isSelected: player.selectedTiles.contains(index), selectionColor: player.color) {
                        message = player.trySelecting(index, in: game)
                    }
                }
            }
            .disabled(message != nil)
            
            if let message {
                VStack {
                    Text(message)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .font(.headline)
                    
                    Button("OK", action: dismissMessage)
                        .buttonStyle(.borderedProminent)
                }
                .padding()
                .background(.black.opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .transition(.scale)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    func dismissMessage() {
        withAnimation {
            message = nil
        }
    }
}

#Preview {
    LetterGridView(player: Player(color: .orange), game: Game())
}
