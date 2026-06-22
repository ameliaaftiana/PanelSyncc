//
//  GenreDetailView.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 21/06/26.
//

import SwiftUI

struct GenreDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var dataLoader = WebtoonDataLoader()
    
    let genre: String
    @State private var selectedTab: Int = 0 // 0 = On Going, 1 = Completed
    
    @State private var selectedWebtoon: Webtoon? = nil

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var filteredWebtoons: [Webtoon] {
        let statusFilter: WebtoonStatus = selectedTab == 0 ? .ongoing : .completed
        return dataLoader.webtoons.filter { webtoon in
            webtoon.genre == genre && webtoon.status == statusFilter
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            // ── 1. Custom Header ──────────────────────────────────────────────
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(18)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }

                Spacer()

                Text(genre)
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

            // ── 2. Custom Segmented Picker ───────────────────────────────
            HStack(spacing: 0) {
                Button(action: { selectedTab = 0 }) {
                    Text("On Going")
                        .font(.searchText)
                        .foregroundColor(selectedTab == 0 ? .panelDark : .panelSecondary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(selectedTab == 0 ? Color.white : Color.clear)
                        .clipShape(Capsule())
                }

                Button(action: { selectedTab = 1 }) {
                    Text("Completed")
                        .font(.searchText)
                        .foregroundColor(selectedTab == 1 ? .panelDark : .panelSecondary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(selectedTab == 1 ? Color.white : Color.clear)
                        .clipShape(Capsule())
                }
            }
            .padding(0)
            .background(Color.white)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color(white: 0.9), lineWidth: 1))
            .padding(.horizontal)
            .padding(.bottom, 20)

            // ── 3. Comic Grid ───────────────────────────────────────────
            ScrollView(showsIndicators: false) {
                if filteredWebtoons.isEmpty {
                    Text("No comics found in this category.")
                        .foregroundColor(.gray)
                        .padding(.top, 40)
                } else {
                    LazyVGrid(columns: columns, spacing: 24) {
                        ForEach(filteredWebtoons) { webtoon in
                            // Since GridComicCard uses the new randomizer, it automatically applies here too!
                            Button(action: {
                                selectedWebtoon = webtoon
                            }) {
                                GridComicCard(webtoon: webtoon)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 100)
                }
            }
        }
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
        .navigationBarHidden(true)
        .navigationDestination(item: $selectedWebtoon) { webtoon in
            ComicDetailViewWrapper(webtoon: webtoon, dataLoader: dataLoader)
        }
        .onAppear {
            dataLoader.loadFromBundle()
        }
    }
}

#Preview {
    NavigationStack {
        GenreDetailView(genre: "Fantasy")
    }
}
