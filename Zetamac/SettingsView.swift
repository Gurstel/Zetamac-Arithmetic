//
//  SettingsView.swift
//  Zetamac
//
//  Created by Omar Shalaby on 2/7/24.
//'init(_:)' declared here (SwiftUI.Form)

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
                        .keyboardType(.numberPad)
                    Text("to")
                    TextField("High", value: $settings.additionRange1.1, formatter: numberFormatter)
                        .keyboardType(.numberPad)
                    Text(")")
                    Text("+ (")
                    TextField("Low", value: $settings.additionRange2.0, formatter: numberFormatter)
                        .keyboardType(.numberPad)
                    Text("to")
                    TextField("High", value: $settings.additionRange2.1, formatter: numberFormatter)
                        .keyboardType(.numberPad)
                    Text(")")
                }
            }
            Section(header: Text("Multiplication"), footer: Text("Division is multiplication problems in reverse")) {
                VStack{
                    HStack {
                        Text("(")
                        TextField("Low", value: $settings.multiplicationRange1.0, formatter: numberFormatter)
                            .keyboardType(.numberPad)
                        Text("to")
                        TextField("High", value: $settings.multiplicationRange1.1, formatter: numberFormatter)
                            .keyboardType(.numberPad)
                        Text(")")
                        Text("× (")
                        TextField("Low", value: $settings.multiplicationRange2.0, formatter: numberFormatter)
                            .keyboardType(.numberPad)
                        Text("to")
                        TextField("High", value: $settings.multiplicationRange2.1, formatter: numberFormatter)
                            .keyboardType(.numberPad)
                        Text(")")
                    }
                    
                }
                
            }
            Section(header: Text("Time Limit"), footer: Text("Must be in range of 5 to 300 seconds")) {
                TextField("Time Limit", value: $settings.gameDuration, formatter: numberFormatter)
                    .keyboardType(.numberPad)
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
