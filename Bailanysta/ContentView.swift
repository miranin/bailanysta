//
//  ContentView.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var themeManager = AnimeThemeManager()
    
    var body: some View {
        SplashView(themeManager: themeManager)
    }
}

#Preview {
    ContentView()
}
