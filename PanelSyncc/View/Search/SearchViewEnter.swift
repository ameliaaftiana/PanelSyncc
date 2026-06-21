//
//  SearchViewEnter.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 21/06/26.
//


import SwiftUI

struct SearchViewEnter: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var searchText: String
    @ObservedObject var dataLoader: WebtoonDataLoader
    
    // FIX: Add state to control comic navigation inside this view
    @State private var selectedWebtoon: Webtoon? = nil
    
    var searchResults: [Webtoon] {
        if searchText.isEmpty { return [] }
        return dataLoader.webtoons.filter { webtoon in
            webtoon.title.localizedCaseInsensitiveContains(searchText) ||
            webtoon.author.localizedCaseInsensitiveContains(searchText) ||
            webtoon.genre.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var groupedResults: [(String, [Webtoon])] {
        let grouped = Dictionary(grouping: searchResults, by: { $0.genre })
        return grouped.map { ($0.key, $0.value) }.sorted { $0.0 < $1.0 }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // ── 1. Custom Header ──────────────────────────────────────────────
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(16)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }
                
                Spacer()
                
                Text("Search")
                    .font(.rankTitle)
                    .foregroundColor(.panelDark)
                
                Spacer()
                
                Button(action: { /* Notifications */ }) {
                    Image(systemName: "bell")
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
            .padding(.bottom, 20)
            
            // ── 2. Search Bar ─────────────────────────────────────────────────
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .font(.system(size: 16, weight: .medium))
                
                TextField("Search", text: $searchText)
                    .font(.subheadline)
                    .foregroundColor(.black)
                
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
            .padding(.bottom, 18)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    Text("\(searchResults.count) Results for \"\(searchText)\"")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    if searchResults.isEmpty {
                        Text("No comics found.")
                            .foregroundColor(.gray)
                            .padding(.top, 40)
                    } else {
                        ForEach(groupedResults, id: \.0) { genre, webtoons in
                            // Pass the binding so the row can trigger navigation
                            SearchCategoryRow(title: genre, webtoons: webtoons, selectedWebtoon: $selectedWebtoon)
                        }
                    }
                    Spacer(minLength: 100)
                }
            }
        }
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        // FIX: The modern way to handle navigation inside a pushed view
        .navigationDestination(item: $selectedWebtoon) { webtoon in
            ComicDetailViewWrapper(webtoon: webtoon, dataLoader: dataLoader)
                .toolbar(.hidden, for: .tabBar)
                .navigationDestination(item: $selectedWebtoon) { webtoon in
                    ComicDetailViewWrapper(webtoon: webtoon, dataLoader: dataLoader)
                }
        }
        
    }
}

// MARK: - Components

struct SearchCategoryRow: View {
    let title: String
    let webtoons: [Webtoon]
    @Binding var selectedWebtoon: Webtoon? // Passed down to trigger navigation
    
    // Control navigation to GenreDetailView
    @State private var navigateToGenre: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Spacer()
                
                Button(action: { navigateToGenre = true }) {
                    Text("See All")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .underline()
                }
            }
            .padding(.horizontal, 24)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(webtoons) { webtoon in
                        // FIX: Replaced NavigationLink with a solid Button
                        Button(action: {
                            selectedWebtoon = webtoon
                        }) {
                            GridComicCard(webtoon: webtoon)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 24)
            }
        }
        .navigationDestination(isPresented: $navigateToGenre) {
            GenreDetailView(genre: title)
        }
    }
}

// MARK: - Shared Grid Comic Card
struct GridComicCard: View {
    let webtoon: Webtoon
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            WebtoonThumbnailView(url: webtoon.thumbnail, width: 110, height: 150, cornerRadius: 12)
            
            Text(webtoon.title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .lineLimit(1)
            
            Text("\(webtoon.ratingFormatted) ★ - \(webtoon.view)")
                .font(.caption2)
                .foregroundColor(.gray)
        }
        .frame(width: 110)
    }
}

#Preview {
    NavigationStack {
        SearchViewEnter(searchText: "Fantasy", dataLoader: WebtoonDataLoader())
    }
}
