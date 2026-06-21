//
//  ContentView.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 17/06/26.
//

import SwiftUI

enum PanelTabBar: String, CaseIterable {
    case home = "Home"
    case library = "Library"
    case friends = "Friends"
    case profile = "Profile"
    case search = "Search"
    
    func symbol(isActive: Bool) -> String {
        switch self {
        case .home:
            return isActive ? "house.fill" : "house"
        case .library:
            return isActive ? "books.vertical.fill" : "books.vertical"
        case .friends:
            return isActive ? "person.3.fill" : "person.3"
        case .profile:
            return isActive ? "person.fill" : "person"
        case .search:
            return "magnifyingglass"
        }
    }
}

struct ContentView: View {
    @State private var activeTab: PanelTabBar = .home
    @State private var previousTab: PanelTabBar = .home

    var body: some View {
        TabView(selection: $activeTab) {
            Tab(PanelTabBar.home.rawValue, systemImage: PanelTabBar.home.symbol(isActive: activeTab == .home), value: .home) {
                HomeView()
            }

            Tab(PanelTabBar.library.rawValue, systemImage: PanelTabBar.library.symbol(isActive: activeTab == .library), value: .library) {
                LibraryView()
            }

            Tab(PanelTabBar.friends.rawValue, systemImage: PanelTabBar.friends.symbol(isActive: activeTab == .friends), value: .friends) {
                NavigationStack {
                    FriendsPageView()
                }
            }

            Tab(PanelTabBar.profile.rawValue, systemImage: PanelTabBar.profile.symbol(isActive: activeTab == .profile), value: .profile) {
                ProfileView()
            }

            Tab(PanelTabBar.search.rawValue, systemImage: PanelTabBar.search.symbol(isActive: activeTab == .search), value: .search, role: .search) {
                SearchView()
            }
        }
        .tint(.blue)
    }
}

#Preview {
    ContentView()
}
