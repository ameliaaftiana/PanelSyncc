//
//  LibraryView.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 19/06/26.
//


import SwiftUI

struct LibraryView: View {
    // 1. Initialize your database/data loader
    @StateObject private var dataLoader = WebtoonDataLoader()
    
    // 2. State for the selected tab
    @State private var selectedTab: String = "Current Reading"
    let tabs = ["Current Reading", "Plan to Read", "Completed", "Download", "Others"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // MARK: - Custom Header
                HStack {
                    Text("Library")
                        .font(.libraryTitle)
                        .foregroundColor(.panelDark)
                    
                    Spacer()
                    
                    NavigationLink {
                        Text("Notification View")
                    } label: {
                        Image(systemName: "bell.badge")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.black)
                            .frame(width: 32, height: 32)
                            .background(.regularMaterial, in: Circle())
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .padding(.bottom, 12)
                
                // MARK: - Custom Tab Bar
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(tabs, id: \.self) { tab in
                            VStack(spacing: 8) {
                                Text(tab)
                                    .font(selectedTab == tab ? .libraryMenuSelected : .libraryMenuUnSelected)
                                    .foregroundColor(selectedTab == tab ? .panelDark : .panelPrimary)
                                
                                Rectangle()
                                    .fill(selectedTab == tab ? Color.black : Color.clear)
                                    .frame(height: 2)
                            }
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    selectedTab = tab
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 8)
                
                // MARK: - Scrollable Dynamic Content
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 14) {
                        // Iterating over our dynamic computed property
                        ForEach(filteredWebtoons) { webtoon in
                            LibraryComicCard(
                                genres: [webtoon.genre],
                                title: webtoon.title,
                                description: webtoon.summary,
                                imageUrl: webtoon.thumbnail,
                                rating: Double(webtoon.rating) ?? 0.0,
                                readers: parseCount(webtoon.view),
                                loves: parseCount(webtoon.like),
                                bookmarks: parseCount(webtoon.subscribe)
                            )
                        }
                    }
                    .padding()
                }
            }
            // Matching the light gray app background from the screenshot
            .background(Color(UIColor.systemGray6).ignoresSafeArea())
            .navigationBarHidden(true) 
            .onAppear {
                dataLoader.loadFromBundle()
            }
        }
    }
    
    // MARK: - Filter Logic
    
    /// Returns a different list of data depending on the selected tab
    private var filteredWebtoons: [Webtoon] {
        switch selectedTab {
        case "Current Reading":
            // E.g., Return the top 10 items
            return Array(dataLoader.webtoons.prefix(10))
        case "Plan to Read":
            // E.g., Sort by likes (highest first)
            return dataLoader.webtoons.sorted { parseCount($0.like) > parseCount($1.like) }
        case "Completed":
            // E.g., Mocking a specific slice for downloads
            return Array(dataLoader.webtoons.dropFirst(5).prefix(5))
        case "Download":
            // E.g., Filter items with a rating higher than 9.5
            return dataLoader.webtoons.filter { (Double($0.rating) ?? 0.0) > 9.5 }
        case "Others":
            // E.g., Mocking another slice for notes
            return Array(dataLoader.webtoons.suffix(3))
        default:
            return dataLoader.webtoons
        }
    }
    
    // MARK: - Helper Methods
    
    /// Converts formatted string numbers (e.g., "1.5M", "10k") to integers.
    private func parseCount(_ stringValue: String) -> Int {
        let cleanStr = stringValue.lowercased().replacingOccurrences(of: ",", with: "")
        let numbersOnly = cleanStr.filter { "0123456789.".contains($0) }
        guard let number = Double(numbersOnly) else { return 0 }
        
        if cleanStr.contains("m") || cleanStr.contains("mil") {
            return Int(number * 1_000_000)
        } else if cleanStr.contains("k") {
            return Int(number * 1_000)
        }
        return Int(number)
    }
}

#Preview {
    LibraryView()
}
