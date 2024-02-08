//
//  GameViewModel.swift
//  Zetamac
//
//  Created by Omar Shalaby on 2/7/24.
//

import Foundation

class GameViewModel: ObservableObject {
    
    @Published var userAnswer: String = ""
    
    @Published var currentQuestion: String = ""
    @Published var currentAnswer: String = ""
    @Published var score: Int = 0
    @Published var timeRemaining: Int
    var gameTimer: Timer?
    var settings: GameSettings
    
    init(settings: GameSettings) {
        self.settings = settings
        self.settings.loadSettings()
        self.timeRemaining = settings.gameDuration
        generateQuestion()
        startTimer()
    }
    
    func startTimer() {
        gameTimer?.invalidate()
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.gameTimer?.invalidate()

            }
        }
    }
    
    func checkAnswer(){
        if userAnswer == currentAnswer {
            score += 1
            userAnswer = ""
            generateQuestion()
        }
    }
    
    
}

extension GameViewModel {
    func generateQuestion() {
        let operations = availableOperations()
        guard !operations.isEmpty else {
            currentQuestion = "Please enable at least one operation type in settings."
            return
        }
        
        let operation = operations.randomElement()!
        var number1: Int = 0
        var number2: Int = 0
        
        switch operation {
        case .addition:
            number1 = Int.random(in: settings.additionRange1.0...settings.additionRange1.1)
            number2 = Int.random(in: settings.additionRange2.0...settings.additionRange2.1)
            currentQuestion = "\(number1) + \(number2)"
        case .subtraction:
            number2 = Int.random(in: settings.additionRange2.0...settings.additionRange2.1)
            let tempResult = Int.random(in: settings.additionRange1.0...settings.additionRange1.1) // Ensure non-negative result
            number1 = tempResult + number2
            currentQuestion = "\(number1) - \(number2)"
        case .multiplication:
            number1 = Int.random(in: settings.multiplicationRange1.0...settings.multiplicationRange1.1)
            number2 = Int.random(in: settings.multiplicationRange2.0...settings.multiplicationRange2.1)
            currentQuestion = "\(number1) × \(number2)"
        case .division:
            number2 = Int.random(in: settings.multiplicationRange1.0...settings.multiplicationRange1.1)
            let tempResult = Int.random(in: settings.multiplicationRange2.0...settings.multiplicationRange2.1)
            number1 = number2 * tempResult
            currentQuestion = "\(number1) ÷ \(number2)"
        }
        
   
        switch operation {
        case .addition:
            currentAnswer = String(number1 + number2)
        case .subtraction:
            currentAnswer = String(number1 - number2)
        case .multiplication:
            currentAnswer = String(number1 * number2)
        case .division:
            currentAnswer = String(number1 / number2)
        }
    }
    
    private func availableOperations() -> [OperationType] {
        var operations: [OperationType] = []
        if settings.additionEnabled { operations.append(.addition) }
        if settings.subtractionEnabled { operations.append(.subtraction) }
        if settings.multiplicationEnabled { operations.append(.multiplication) }
        if settings.divisionEnabled { operations.append(.division) }
        return operations
    }
    
    enum OperationType {
        case addition, subtraction, multiplication, division
    }
}

extension GameViewModel {
    func pauseTimer() {
        gameTimer?.invalidate()
    }
    
    func resumeTimer() {
        timeRemaining = settings.gameDuration
        startTimer()
    }
    
    func resetGame() {
            pauseTimer()
            score = 0
            timeRemaining = settings.gameDuration
            generateQuestion() 
    }
}
