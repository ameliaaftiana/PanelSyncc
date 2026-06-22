//
//  LibraryView.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 18/06/26.
//

import SwiftUI

struct LibraryView: View {
    @StateObject private var dataLoader = WebtoonDataLoader()
    @State private var selectedWebtoon: Webtoon? = nil
    @State private var selectedTab: String = "Current Reading"
    let tabs = ["Current Reading", "Plan to Read", "Completed", "Download", "Others"]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Text("Library").font(.libraryTitle).foregroundColor(.panelDark)
                    Spacer()
                    NavigationLink { Text("Notification View") } label: {
                        Image(systemName: "bell.badge")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(16).background(Color.white).clipShape(Circle())
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                }
                .padding(.horizontal).padding(.top, 10).padding(.bottom, 20)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(tabs, id: \.self) { tab in
                            VStack(spacing: 8) {
                                Text(tab).font(selectedTab == tab ? .libraryMenuSelected : .libraryMenuUnSelected)
                                    .foregroundColor(selectedTab == tab ? .panelDark : .panelPrimary)
                                Rectangle().fill(selectedTab == tab ? Color.black : Color.clear).frame(height: 2)
                            }
                            .onTapGesture { withAnimation(.easeInOut(duration: 0.2)) { selectedTab = tab } }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 10)

                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 14) {
                        ForEach(filteredWebtoons) { webtoon in
                            LibraryComicCard(
                                genres: [webtoon.genre],
                                title: webtoon.title,
                                description: webtoon.summary,
                                imageUrl: String(format: "%02d", Int.random(in: 1...21)),
                                rating: webtoon.rating, // FIX: Passed directly without Double() or ??
                                readers: parseCount(webtoon.view),
                                loves: parseCount(webtoon.like),
                                bookmarks: parseCount(webtoon.subscribe),
                                onTap: { selectedWebtoon = webtoon }
                            )
                        }
                    }
                    .padding()
                }
            }
            .background(Color(UIColor.systemGray6).ignoresSafeArea())
            .navigationBarHidden(true)
            .navigationDestination(item: $selectedWebtoon) { webtoon in
                ComicDetailViewWrapper(webtoon: webtoon, dataLoader: dataLoader)
            }
            .onAppear { dataLoader.loadFromBundle() }
        }
    }

    private var filteredWebtoons: [Webtoon] {
        switch selectedTab {
        case "Current Reading": return Array(dataLoader.webtoons.prefix(10))
        case "Plan to Read": return dataLoader.webtoons.sorted { parseCount($0.like) > parseCount($1.like) }
        case "Completed": return Array(dataLoader.webtoons.dropFirst(5).prefix(5))
        case "Download": return dataLoader.webtoons.filter { $0.rating > 9.5 }
        case "Others": return Array(dataLoader.webtoons.suffix(3))
        default: return dataLoader.webtoons
        }
    }

    private func parseCount(_ stringValue: String) -> Int {
        let cleanStr = stringValue.lowercased().replacingOccurrences(of: ",", with: "")
        let numbersOnly = cleanStr.filter { "0123456789.".contains($0) }
        guard let number = Double(numbersOnly) else { return 0 }
        if cleanStr.contains("m") || cleanStr.contains("mil") { return Int(number * 1_000_000) }
        else if cleanStr.contains("k") { return Int(number * 1_000) }
        return Int(number)
    }
}

#Preview {
    LibraryView()
}
