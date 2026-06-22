//
//  SearchView.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 19/06/26.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var dataLoader = WebtoonDataLoader()
    
    // Navigation States
    @State private var searchText: String = ""
    @State private var recentSearches = ["Fantasy", "Romance", "Dead"]
    
    @State private var navigateToResults: Bool = false
    @State private var selectedWebtoon: Webtoon? = nil
    
    @State private var navigateToGenre: Bool = false
    @State private var selectedGenre: String = ""

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // MARK: - Header
                HStack {
                    Text("Search")
                        .font(.libraryTitle)
                        .foregroundColor(.panelDark)

                    Spacer()

                    Button(action: { print("Notifications Tapped") }) {
                        Image(systemName: "bell.badge")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(14)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .padding(.bottom, 12)

                // MARK: - Scrollable Content
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 28) {

                        // MARK: 1. Search Bar
                        HStack(spacing: 12) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .font(.system(size: 16, weight: .medium))

                            TextField("Search", text: $searchText)
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .onSubmit {
                                    if !searchText.isEmpty {
                                        if !recentSearches.contains(searchText) {
                                            recentSearches.insert(searchText, at: 0)
                                        }
                                        navigateToResults = true
                                    }
                                }

                            if !searchText.isEmpty {
                                Button(action: { searchText = "" }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                            }

                            Image(systemName: "mic")
                                .foregroundColor(.gray)
                                .font(.system(size: 16, weight: .medium))
                        }
                        .padding(.horizontal, 16)
                        .frame(height: 50)
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 3)
                        .padding(.horizontal)

                        // MARK: 2. Recent Search
                        if !recentSearches.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Recent Search")
                                    .font(.otherTitle)
                                    .foregroundColor(.panelDark)
                                    .padding(.horizontal)

                                VStack(spacing: 8) {
                                    ForEach(recentSearches, id: \.self) { search in
                                        RecentSearchRow(text: search) {
                                            if let index = recentSearches.firstIndex(of: search) {
                                                recentSearches.remove(at: index)
                                            }
                                        }
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            searchText = search
                                            navigateToResults = true
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }

                        // MARK: 3. Trending Search
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Trending Search")
                                .font(.otherTitle)
                                .foregroundColor(.panelDark)
                                .padding(.horizontal)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(trendingWebtoons) { webtoon in
                                        Button(action: {
                                            selectedWebtoon = webtoon
                                        }) {
                                            TrendingSearchCard(
                                                title: webtoon.title,
                                                author: webtoon.author,
                                                // NEW: Force random image 01-21
                                                imageUrl: String(format: "%02d", Int.random(in: 1...21))
                                            )
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }

                        // MARK: 4. Dynamic Categories
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Categories")
                                .font(.otherTitle)
                                .foregroundColor(.panelDark)
                                .padding(.horizontal)

                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(dynamicCategories, id: \.title) { category in
                                    Button(action: {
                                        selectedGenre = category.title
                                        navigateToGenre = true
                                    }) {
                                        CategoryCard(
                                            title: category.title,
                                            seriesCount: category.count,
                                            // NEW: Force random image 01-21
                                            imageUrl: String(format: "%02d", Int.random(in: 1...21))
                                        )
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 100)
                        }
                    }
                    .padding(.top, 8)
                }
            }
            .background(Color(UIColor.systemGray6).ignoresSafeArea())
            .navigationBarHidden(true)
            
            // MARK: - Navigation Destinations
            .navigationDestination(isPresented: $navigateToResults) {
                SearchViewEnter(searchText: searchText, dataLoader: dataLoader)
            }
            .navigationDestination(isPresented: $navigateToGenre) {
                GenreDetailView(genre: selectedGenre)
            }
            .navigationDestination(item: $selectedWebtoon) { webtoon in
                ComicDetailViewWrapper(webtoon: webtoon, dataLoader: dataLoader)
            }
            .onAppear {
                dataLoader.loadFromBundle()
            }
        }
    }

    // MARK: - Logic Helpers
    private var trendingWebtoons: [Webtoon] {
        let sorted = dataLoader.webtoons.sorted { parseCount($0.view) > parseCount($1.view) }
        return Array(sorted.prefix(5))
    }

    struct CategoryItem {
        let title: String
        let count: Int
        let imageUrl: String
        let firstWebtoon: Webtoon?
    }

    private var dynamicCategories: [CategoryItem] {
        let grouped = Dictionary(grouping: dataLoader.webtoons, by: { $0.genre })
        var items = grouped.map { (genre, webtoonsInGenre) in
            CategoryItem(title: genre, count: webtoonsInGenre.count, imageUrl: webtoonsInGenre.first?.thumbnail ?? "", firstWebtoon: webtoonsInGenre.first)
        }
        items.sort { $0.count > $1.count }
        return items
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
    NavigationStack {
        SearchViewEnter(searchText: "Fantasy", dataLoader: WebtoonDataLoader())
    }
}
