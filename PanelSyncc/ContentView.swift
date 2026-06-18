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
    @State private var isSearchPresented: Bool = false
    
    var body: some View {
        TabView(selection: $activeTab) {
            Tab(PanelTabBar.home.rawValue, systemImage: PanelTabBar.home.symbol(isActive: activeTab == .home), value: .home) {
                HomeView()
            }
            
            Tab(PanelTabBar.library.rawValue, systemImage: PanelTabBar.library.symbol(isActive: activeTab == .library), value: .library) {
                LibraryView()
            }
            
            Tab(PanelTabBar.friends.rawValue, systemImage: PanelTabBar.friends.symbol(isActive: activeTab == .friends), value: .friends) {
                FriendsPageView()
            }
            
            Tab(PanelTabBar.profile.rawValue, systemImage: PanelTabBar.profile.symbol(isActive: activeTab == .profile), value: .profile) {
                Text("Profile View Placeholder")
            }
            
            Tab(PanelTabBar.search.rawValue, systemImage: PanelTabBar.search.symbol(isActive: activeTab == .search), value: .search, role: .search) {
                SearchViewPlaceholder(isPresented: $isSearchPresented)
            }
        }
        .tint(.blue)
        
        .onChange(of: activeTab) { oldValue, newValue in
            if newValue == .search {
                isSearchPresented = true
                if oldValue != .search {
                    previousTab = oldValue
                }
            } else {
                isSearchPresented = false
            }
        }
        .onChange(of: isSearchPresented) { oldValue, newValue in
            if newValue == false && activeTab == .search {
                activeTab = previousTab
            }
        }
    }
}

// Temporary Placeholder for Search
struct SearchViewPlaceholder: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Text("Search View Placeholder")
                .font(.title)
            
            Button("Dismiss Search") {
                isPresented = false
            }
            .padding()
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ContentView()
}
