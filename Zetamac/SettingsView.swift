//
//  SettingsView.swift
//  Zetamac
//
//  Created by Omar Shalaby on 2/7/24.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var settings = GameSettings()
    let numberFormatter = NumberFormatter()
    
    var body: some View {
        Form {
            Section(header: Text("Arithmetic Operations")) {
                Toggle("Addition", isOn: $settings.additionEnabled)
                Toggle("Subtraction", isOn: $settings.subtractionEnabled)
                Toggle("Multiplication", isOn: $settings.multiplicationEnabled)
                Toggle("Division", isOn: $settings.divisionEnabled)
            }
            Section(header: Text("Addition"), footer: Text("Subtraction is addition problems in reverse")) {
                HStack {
                    Text("(")
                    TextField("Low", value: $settings.additionRange1.0, formatter: numberFormatter)
                    Text("to")
                    TextField("High", value: $settings.additionRange1.1, formatter: numberFormatter)
                    Text(")")
                    Text("+ (")
                    TextField("Low", value: $settings.additionRange2.0, formatter: numberFormatter)
                    Text("to")
                    TextField("High", value: $settings.additionRange2.1, formatter: numberFormatter)
                    Text(")")
                }
            }
            Section(header: Text("Multiplication"), footer: Text("Division is multiplication problems in reverse")) {
                HStack {
                    Text("(")
                    TextField("Low", value: $settings.multiplicationRange1.0, formatter: numberFormatter)
                    Text("to")
                    TextField("High", value: $settings.multiplicationRange1.1, formatter: numberFormatter)
                    Text(")")
                    Text("× (")
                    TextField("Low", value: $settings.multiplicationRange2.0, formatter: numberFormatter)
                    Text("to")
                    TextField("High", value: $settings.multiplicationRange2.1, formatter: numberFormatter)
                    Text(")")
                }
            }
            
        }
        .navigationBarTitle("Settings")
        .onDisappear {
                    settings.saveSettings()
        }
    }
}


#Preview {
    SettingsView()
}
