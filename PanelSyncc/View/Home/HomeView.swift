import SwiftUI

struct HomeView: View {
    // 1. Initialize your data loader
    @StateObject private var dataLoader = WebtoonDataLoader()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 32) {
                    
                    // MARK: - Section 1: Top Picks
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Top Picks!")
                                .font(.topPicksTitle)
                                .foregroundColor(.panelDark)
                            
                            Spacer()
                            
                            NavigationLink(destination: Text("Top Picks View Placeholder")) {
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
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.bottom, 30)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    notificationButton
                }
            }
        }
        .onAppear {
            dataLoader.loadFromBundle()
        }
    }
    
    // MARK: - Notification Button
    private var notificationButton: some View {
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

#Preview {
    HomeView()
}
