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
            HStack {
                Text("Time: \(gameViewModel.timeRemaining)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Score: \(gameViewModel.score)")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            Spacer()

            Text(gameViewModel.currentQuestion)
                .multilineTextAlignment(.center)
            
            if #available(iOS 17.0, *) {
                TextField("", text: $gameViewModel.userAnswer)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 80)
                    .padding(.top, 20)
                    .disabled(gameViewModel.timeRemaining <= 0)
                    .onChange(of: gameViewModel.userAnswer) {
                        gameViewModel.checkAnswer()
                    }
            } else {
                TextField("", text: $gameViewModel.userAnswer)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 80)
                    .padding(.top, 20)
                    .disabled(gameViewModel.timeRemaining <= 0)
                    .onChange(of: gameViewModel.userAnswer) { newValue in
                        gameViewModel.checkAnswer()
                    }
            }
           
            Spacer()
            
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
