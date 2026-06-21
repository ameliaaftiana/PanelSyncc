//
//  HomeView.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 18/06/26.
//


import SwiftUI

struct HomeView: View {
    // 1. Initialize your data loader
    @StateObject private var dataLoader = WebtoonDataLoader()
    @State private var selectedWebtoon: Webtoon? = nil

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // MARK: - Custom Header
                HStack {
                    Text("Home")
                        .font(.libraryTitle)
                        .foregroundColor(.panelDark)

                    Spacer()

                    NavigationLink {
                        Text("Notification View")
                    } label: {
                        Image(systemName: "bell.badge")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(16)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .padding(.bottom, 12)

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 32) {

                        // MARK: - Section 1: Top Picks
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Top Picks!")
                                    .font(.topPicksTitle)
                                    .foregroundColor(.panelDark)

                                Spacer()

                                NavigationLink(destination: RankView()) {
                                    Text("See All")
                                        .font(.seeAll)
                                        .underline()
                                        .foregroundColor(.panelPrimary)
                                }
                            }
                            .padding(.horizontal)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(dataLoader.webtoons.prefix(5)) { webtoon in
                                        // FIX: Use your built-in onTap parameter instead of a Button wrapper!
                                        TopPicksCard(
                                            title: webtoon.title,
                                            description: webtoon.summary,
                                            genre: webtoon.genre,
                                            imageUrl: webtoon.thumbnail,
                                            rating: webtoon.rating,
                                            readers: parseCount(webtoon.view),
                                            loves: parseCount(webtoon.like),
                                            bookmarks: parseCount(webtoon.subscribe),
                                            onTap: {
                                                selectedWebtoon = webtoon // Triggers navigation!
                                            }
                                        )
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top, 16)

                        // MARK: - Section 2: Continue Reading
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Continue Reading")
                                    .font(.otherTitle)

                                Spacer()

                                NavigationLink(destination: Text("Continue Reading View Placeholder")) {
                                    Text("See All")
                                        .font(.seeAll)
                                        .underline()
                                        .foregroundColor(.panelPrimary)
                                }
                            }
                            .padding(.horizontal)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 4) {
                                    ForEach(dataLoader.webtoons.dropFirst(5).prefix(5)) { webtoon in
                                        // FIX: Use your built-in onTap parameter!
                                        PortraitComicCardSmaller(
                                            title: webtoon.title,
                                            lastChap: "Chap \(webtoon.episodes)",
                                            imageUrl: webtoon.thumbnail,
                                            onTap: {
                                                selectedWebtoon = webtoon
                                            }
                                        )
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }

                        // MARK: - Section 3: Daily Updates
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Daily Updates")
                                    .font(.otherTitle)

                                Spacer()

                                NavigationLink(destination: Text("Daily Updates View Placeholder")) {
                                    Text("See All")
                                        .font(.seeAll)
                                        .underline()
                                        .foregroundColor(.panelPrimary)
                                }
                            }
                            .padding(.horizontal)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(dataLoader.webtoons.dropFirst(10)) { webtoon in
                                        // FIX: Use your built-in onTap parameter!
                                        PortraitComicCard(
                                            title: webtoon.title,
                                            rating: webtoon.ratingFormatted,
                                            readers: webtoon.view,
                                            imageUrl: webtoon.thumbnail,
                                            onTap: {
                                                selectedWebtoon = webtoon
                                            }
                                        )
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.bottom, 30)
                }
            }
            .navigationBarHidden(true)
            .background(Color(UIColor.systemGray6).ignoresSafeArea())
            .navigationDestination(item: $selectedWebtoon) { webtoon in
                ComicDetailViewWrapper(webtoon: webtoon, dataLoader: dataLoader)
            }
        }
        .onAppear {
            dataLoader.loadFromBundle()
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
    HomeView()
}
