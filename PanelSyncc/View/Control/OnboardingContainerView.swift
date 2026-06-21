//
//  OnboardingContainerView.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 18/06/26.
//


import SwiftUI

struct OnboardingContainerView: View {
    // Talks to ContentView to dismiss onboarding
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    
    // Tracks the current page (0 for Page 1, up to 3 for Page 4)
    @State private var currentPage: Int = 0
    let totalPages: Int = 4 // UPDATED: Now set to 4 pages!
    
    var body: some View {
        VStack {
            // MARK: - Top Header (Progress & Skip)
            VStack(spacing: 16) {
                HStack(spacing: 8) {
                    ForEach(0..<totalPages, id: \.self) { index in
                        Capsule()
                            .fill(index == currentPage ? Color.black : Color.gray.opacity(0.3))
                            .frame(height: 4)
                            .animation(.easeInOut, value: currentPage)
                    }
                }
                
                HStack {
                    Text("\(currentPage + 1)/\(totalPages)")
                        .font(.onboardingSkip)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button(action: {
                        // Skip directly to main app
                        hasSeenOnboarding = true
                    }) {
                        Text("SKIP")
                            .font(.onboardingSkip)
                            .tracking(1)
                            .foregroundColor(.black)
                    }
                    // UPDATED: Fades out the SKIP button on the very last page
                    .opacity(currentPage == totalPages - 1 ? 0 : 1)
                    .animation(.easeInOut, value: currentPage)
                }
            }
            .padding(.top, 16)
            .padding(.horizontal, 24)
            
            // MARK: - Swipeable Pages
            TabView(selection: $currentPage) {
                OnboardingPage1()
                    .tag(0)
                
                OnboardingPage2()
                    .tag(1)
                
                // UPDATED: Added pages 3 and 4
                OnboardingPage3()
                    .tag(2)
                
                OnboardingPage4()
                    .tag(3)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            // MARK: - Bottom Next Button
            // UPDATED: Using your custom PrimaryButton component
            PrimaryButton(
                title: currentPage == totalPages - 1 ? "Get Started" : "Next",
                action: {
                    if currentPage < totalPages - 1 {
                        // Go to next page with animation
                        withAnimation {
                            currentPage += 1
                        }
                    } else {
                        // Finish onboarding
                        hasSeenOnboarding = true
                    }
                }
            )
            .padding(.horizontal, 24)
            .padding(.bottom, 16)
        }
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
    }
}

#Preview {
    OnboardingContainerView()
}
