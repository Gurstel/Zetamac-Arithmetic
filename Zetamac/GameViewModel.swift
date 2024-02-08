//
//  GameViewModel.swift
//  Zetamac
//
//  Created by Omar Shalaby on 2/7/24.
//

import Foundation

class GameViewModel: ObservableObject {
    
    @Published var userAnswer: String = "" {
            didSet {
                checkAnswer()
            }
        }
    
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
        gameTimer?.invalidate() // Invalidate any existing timer
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.gameTimer?.invalidate()
                // Handle game end, such as navigating back or showing a score summary
            }
        }
    }
    
    func checkAnswer() {
            if userAnswer == currentAnswer {
                score += 1 // Increment score for correct answer
                userAnswer = "" // Reset user answer
                generateQuestion() // Generate next question
            }
        }
    
    
    // Additional methods as needed for handling user input, etc.
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
            let tempResult = Int.random(in: settings.additionRange1.0...settings.additionRange1.0) // Ensure non-negative result
            number1 = tempResult + number2
            currentQuestion = "\(number1) - \(number2)"
        case .multiplication:
            number1 = Int.random(in: settings.multiplicationRange1.0...settings.multiplicationRange1.1)
            number2 = Int.random(in: settings.multiplicationRange2.0...settings.multiplicationRange2.1)
            currentQuestion = "\(number1) * \(number2)"
        case .division:
            number2 = Int.random(in: settings.multiplicationRange1.0...settings.multiplicationRange1.1)
            let tempResult = Int.random(in: settings.multiplicationRange2.0...settings.multiplicationRange2.1)
            number1 = number2 * tempResult // Ensure whole number division
            currentQuestion = "\(number1) / \(number2)"
        }
        
        // Calculate and store the correct answer for later verification
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
        print("Subtraction is currently", settings.subtractionEnabled)
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
        gameTimer?.invalidate() // Stop the timer
    }
    
    func resumeTimer() {
        if timeRemaining > 0 {
            startTimer()
        }
    }
    
    func resetGame() {
            pauseTimer() // Stop the current timer
            score = 0 // Reset score if needed
            timeRemaining = settings.gameDuration // Reset time back to initial setting
            generateQuestion() // Generate a new question for a fresh start
    }
}
