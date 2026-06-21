import SwiftUI

struct HomeView: View {
    // 1. Initialize your data loader
    @StateObject private var dataLoader = WebtoonDataLoader()
    @State private var selectedWebtoon: Webtoon? = nil

    var body: some View {
        NavigationView {
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
                            .padding(12)
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
                                        TopPicksCard(
                                            title: webtoon.title,
                                            description: webtoon.summary,
                                            genre: webtoon.genre,
                                            imageUrl: webtoon.thumbnail,
                                            rating: webtoon.rating,
                                            readers: parseCount(webtoon.view),
                                            loves: parseCount(webtoon.like),
                                            bookmarks: parseCount(webtoon.subscribe)
                                        )
                                        .onTapGesture {
                                            selectedWebtoon = webtoon
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top, 16)

                        // MARK: - Section 2: Continue Reading
                        VStack(alignment: .leading, spacing: 12) {
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
                                HStack(spacing: 16) {
                                    ForEach(dataLoader.webtoons.dropFirst(5).prefix(5)) { webtoon in
                                        PortraitComicCardSmaller(
                                            title: webtoon.title,
                                            lastChap: "Chap \(webtoon.episodes)",
                                            imageUrl: webtoon.thumbnail
                                        )
                                        .onTapGesture {
                                            selectedWebtoon = webtoon
                                        }
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
                                        PortraitComicCard(
                                            title: webtoon.title,
                                            rating: webtoon.ratingFormatted,
                                            readers: webtoon.view,
                                            imageUrl: webtoon.thumbnail
                                        )
                                        .onTapGesture {
                                            selectedWebtoon = webtoon
                                        }
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
        }
        .onAppear {
            dataLoader.loadFromBundle()
        }
    }

    // MARK: - Helper Methods

    /// Converts formatted string numbers (e.g., "1.5M", "125mil", "10k", "1,500") to integers.
    private func parseCount(_ stringValue: String) -> Int {
        let cleanStr = stringValue.lowercased().replacingOccurrences(of: ",", with: "")

        // Extract only the numbers and decimal point
        let numbersOnly = cleanStr.filter { "0123456789.".contains($0) }
        guard let number = Double(numbersOnly) else { return 0 }

        // Multiply based on suffixes
        if cleanStr.contains("m") || cleanStr.contains("mil") {
            return Int(number * 1_000_000)
        } else if cleanStr.contains("k") {
            return Int(number * 1_000)
        }

        return Int(number)
    }
}

// MARK: - ComicDetailViewWrapper
struct ComicDetailViewWrapper: View {
    let webtoon: Webtoon
    @ObservedObject var dataLoader: WebtoonDataLoader

    var body: some View {
        ComicDetailView(
            webtoon: webtoon,
            chapters: dataLoader.chapters,
            comments: dataLoader.comments,
            featuredCollections: dataLoader.collections,
            peopleAlsoLike: []
        )
    }
}

#Preview {
    HomeView()
}
