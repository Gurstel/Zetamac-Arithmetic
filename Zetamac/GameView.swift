//
//  GameView.swift
//  Zetamac
//
//  Created by Omar Shalaby on 2/7/24.
//

import SwiftUI

import SwiftUI

struct GameView: View {
    @ObservedObject var gameViewModel = GameViewModel(settings: GameSettings())

    var body: some View {
        VStack {
            Text("Time: \(gameViewModel.timeRemaining)")
            Text("Score: \(gameViewModel.score)")
            Text(gameViewModel.currentQuestion)
            TextField("Your answer", text: $gameViewModel.userAnswer)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: gameViewModel.userAnswer) {
                }
        }
        .padding()
        .onAppear {
            gameViewModel.settings.loadSettings()
            gameViewModel.generateQuestion()
            gameViewModel.resumeTimer()
        }
        .onDisappear {
            gameViewModel.resetGame()
        }
    }
}

#Preview {
    GameView()
}
