//
//  HomePageView.swift
//  Zetamac
//
//  Created by Omar Shalaby on 2/7/24.
//

import SwiftUI

struct HomePageView: View {
    
    var body: some View {
        VStack {
            NavigationLink("Start Game", destination: GameView())
            NavigationLink("Settings", destination: SettingsView())
        }
    }

}


#Preview {
    HomePageView()
}
