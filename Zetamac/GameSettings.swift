//
//  GameSettings.swift
//  Zetamac
//
//  Created by Omar Shalaby on 2/7/24.
//

import Foundation

class GameSettings: ObservableObject {
    
    init() {
            loadSettings() // Load saved settings immediately upon initialization
    }
    
    @Published var additionRange1: (Int, Int) = (2, 100)
    @Published var additionRange2: (Int, Int) = (2, 100)
    @Published var multiplicationRange1: (Int, Int) = (2, 12)
    @Published var multiplicationRange2: (Int, Int) = (2, 100)
    @Published var gameDuration: Int = 120
    @Published var additionEnabled: Bool = true
    @Published var subtractionEnabled: Bool = true
    @Published var multiplicationEnabled: Bool = true
    @Published var divisionEnabled: Bool = true

    // Function to reset to default settings
    func resetToDefaults() {
        additionRange1 = (2, 100)
        additionRange2 = (2, 100)
        multiplicationRange1 = (2, 12)
        multiplicationRange2 = (2, 100)
        gameDuration = 120
        additionEnabled = true
        subtractionEnabled = true
        multiplicationEnabled = true
        divisionEnabled = true
    }
}

extension GameSettings {

    func saveSettings() {
            UserDefaults.standard.set(additionRange1.0, forKey: "additionRange1Lower")
            UserDefaults.standard.set(additionRange1.1, forKey: "additionRange1Upper")
            UserDefaults.standard.set(additionRange2.0, forKey: "additionRange2Lower")
            UserDefaults.standard.set(additionRange2.1, forKey: "additionRange2Upper")
            UserDefaults.standard.set(multiplicationRange1.0, forKey: "multiplicationRange1Lower")
            UserDefaults.standard.set(multiplicationRange1.1, forKey: "multiplicationRange1Upper")
            UserDefaults.standard.set(multiplicationRange2.0, forKey: "multiplicationRange2Lower")
            UserDefaults.standard.set(multiplicationRange2.1, forKey: "multiplicationRange2Upper")
            UserDefaults.standard.set(gameDuration, forKey: "gameDuration")
            UserDefaults.standard.set(additionEnabled, forKey: "additionEnabled")
            UserDefaults.standard.set(subtractionEnabled, forKey: "subtractionEnabled")
            UserDefaults.standard.set(multiplicationEnabled, forKey: "multiplicationEnabled")
            UserDefaults.standard.set(divisionEnabled, forKey: "divisionEnabled")
            validateRanges()
        }
        
    func loadSettings() {
        let defaults = UserDefaults.standard
        
        additionRange1 = (
            defaults.integer(forKey: "additionRange1Lower"),
            defaults.integer(forKey: "additionRange1Upper")
        )
        additionRange2 = (
            defaults.integer(forKey: "additionRange2Lower"),
            defaults.integer(forKey: "additionRange2Upper")
        )
        multiplicationRange1 = (
            defaults.integer(forKey: "multiplicationRange1Lower"),
            defaults.integer(forKey: "multiplicationRange1Upper")
        )
        multiplicationRange2 = (
            defaults.integer(forKey: "multiplicationRange2Lower"),
            defaults.integer(forKey: "multiplicationRange2Upper")
        )
        gameDuration = defaults.integer(forKey: "gameDuration")
        if gameDuration == 0 { gameDuration = 120 } // Set default if not stored
        
        additionEnabled = defaults.bool(forKey: "additionEnabled")
        subtractionEnabled = defaults.bool(forKey: "subtractionEnabled")
        multiplicationEnabled = defaults.bool(forKey: "multiplicationEnabled")
        divisionEnabled = defaults.bool(forKey: "divisionEnabled")
        
        // Ensure loaded ranges are valid, setting to default if not
        validateRanges()
    }
        
    private func validateRanges() {
        if additionRange1.0 < 2 || additionRange1.1 < 2 || additionRange1.0 > additionRange1.1 { additionRange1 = (2, 100) }
        if additionRange2.0 < 2 || additionRange2.1 < 2 || additionRange2.0 > additionRange2.1 { additionRange2 = (2, 100) }
        if multiplicationRange1.0 < 2 || multiplicationRange1.1 < 2 || multiplicationRange1.0 > multiplicationRange1.1 { multiplicationRange1 = (2, 12) }
        if multiplicationRange2.0 < 2 || multiplicationRange2.1 < 2 || multiplicationRange2.0 > multiplicationRange2.1 { multiplicationRange2 = (2, 100) }
        if gameDuration < 5 || gameDuration > 300 { gameDuration = 120 }
    }
}
