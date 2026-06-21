//
//  RankView.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 19/06/26.
//

import SwiftUI

struct RankView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var dataLoader = WebtoonDataLoader()
    @State private var selectedTab: String = "Popular"
    @State private var selectedWebtoon: Webtoon? = nil

    let tabs = ["Popular", "Trending", "Newcomer", "Action", "Fantasy", "Romance", "Sci-Fi"]

    var body: some View {
        VStack(spacing: 0) {

            // MARK: - Custom Header
            HStack {
                // Back Button
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(15)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }

                Spacer()

                // Title
                Text("Rank")
                    .font(.rankTitle)
                    .foregroundColor(.panelDark)

                Spacer()

                // Notification Button
                NavigationLink {
                    Text("Notification View")
                } label: {
                    Image(systemName: "bell.badge")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(12)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }
            }
            .padding(.horizontal)
            .padding(.top, 10) // Adjust if needed to fit nicely under the dynamic island/notch
            .padding(.bottom, 12)
            .background(Color(UIColor.white)) // Matches the top background color

            // MARK: - Custom Tab Bar (Matching Library Style)
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
            .padding(.top, 1)
            .padding(.bottom, 10)
            .background(Color.white)

            // MARK: - Scrollable Rank Content
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 24) {
                    ForEach(Array(rankedWebtoons.enumerated()), id: \.element.id) { index, webtoon in
                        RankComicCard(
                            rank: index + 1,
                            genres: [webtoon.genre],
                            title: webtoon.title,
                            description: webtoon.summary,
                            imageUrl: webtoon.thumbnail,
                            rating: Double(webtoon.rating) ?? 0.0,
                            readers: parseCount(webtoon.view),
                            loves: parseCount(webtoon.like),
                            bookmarks: parseCount(webtoon.subscribe)
                        )
                        .onTapGesture {
                            selectedWebtoon = webtoon
                        }
                    }
                }
                .padding()
            }
        }
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
        .navigationBarHidden(true) // Hides the default iOS Navigation Bar
        .background(
            NavigationLink(
                destination: selectedWebtoon.map { webtoon in
                    ComicDetailViewWrapper(webtoon: webtoon, dataLoader: dataLoader)
                },
                isActive: Binding(
                    get: { selectedWebtoon != nil },
                    set: { if !$0 { selectedWebtoon = nil } }
                )
            ) { EmptyView() }
        )
        .onAppear {
            dataLoader.loadFromBundle()
        }
    }

    // MARK: - Rank Sorting & Filtering Logic (Top 10)
    private var rankedWebtoons: [Webtoon] {
        let allItems = dataLoader.webtoons

        switch selectedTab {
        case "Popular":
            let sorted = allItems.sorted { parseCount($0.view) > parseCount($1.view) }
            return Array(sorted.prefix(10))

        case "Trending":
            let sorted = allItems.sorted { parseCount($0.subscribe) > parseCount($1.subscribe) }
            return Array(sorted.prefix(10))

        case "Newcomer":
            let sorted = allItems.sorted { $0.episodes < $1.episodes }
            return Array(sorted.prefix(10))

        default:
            let filtered = allItems.filter { $0.genre.lowercased() == selectedTab.lowercased() }
            let sorted = filtered.sorted { parseCount($0.view) > parseCount($1.view) }
            return Array(sorted.prefix(10))
        }
    }

    // MARK: - Helper Methods
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
    NavigationView {
        RankView()
    }
}
