//
//  PanelSynccApp.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 17/06/26.
//

import SwiftUI

@main
struct PanelSynccApp: App {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false

    var body: some Scene {
        WindowGroup {
            // Apply the logic inside the content view builder
            Group {
                if hasSeenOnboarding {
                    ContentView()
                } else {
                    OnboardingContainerView()
                }
            }
            .animation(.easeInOut, value: hasSeenOnboarding) // Applied here to the views
        }
    }
}
