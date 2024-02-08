//
//  HomePageView.swift
//  Zetamac
//
//  Created by Omar Shalaby on 2/7/24.
//

import SwiftUI

struct HomePageView: View {
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Zetamac")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding()
            NavigationLink("Start Game", destination: GameView())
                .buttonStyle(.borderedProminent)
            NavigationLink("Settings", destination: SettingsView())
        }
    }

}


#Preview {
    HomePageView()
}
