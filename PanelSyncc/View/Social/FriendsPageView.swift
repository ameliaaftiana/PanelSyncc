//
//  FriendsPageView.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 19/06/26.
//

import SwiftUI

// A simple dummy view for the inbox destination
struct InboxPage: View {
    var body: some View {
        Text("Welcome to the Inbox")
            .font(.title)
            .navigationTitle("Inbox")
    }
}

struct FriendsPageView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        // 1. Wrap the entire view content in a NavigationStack
        NavigationStack {
            VStack(spacing: 0) {
                // Header Section
                HStack {
                    Text("Friends")
                        .font(.libraryTitle)
                        .foregroundColor(.panelDark)
                    
                    Spacer()
                    
                    HStack(spacing: 12) {
                        Button(action: {
                            print("Add Friend Tapped")
                        }) {
                            Image(systemName: "person.badge.plus")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                                .padding(12)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                        }
                   
                        NavigationLink(destination: InboxPage()) {
                            Image(systemName: "tray")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                                .padding(12)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                        }                        
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 60)
                .padding(.bottom, 20)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(UIColor.systemGray4), Color.white]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea(edges: .top)
                )
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        // Search Bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.panelPrimary)
                            
                            TextField("Search", text: $searchText)
                                .foregroundColor(.panelDark)
                            
                            Image(systemName: "mic")
                                .foregroundColor(.panelPrimary)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                .background(Color.white)
                        )
                        .padding(.horizontal, 24)
                        
                        // Pending Request Section
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Pending Request")
                                    .font(.otherTitle)
                                    .foregroundColor(.panelDark)
                                
                                Spacer()
                                
                                Button(action: {
                                    print("See All Tapped")
                                }) {
                                    Text("See All")
                                        .font(.seeAll)
                                        .foregroundColor(.panelPrimary)
                                        .underline()
                                }
                            }
                            .padding(.horizontal, 24)
                            
                            VStack(spacing: 12) {
                                FriendRequestRow(
                                    username: "NeonShadow",
                                    mutualFriendsCount: 4,
                                    acceptAction: {},
                                    declineAction: {}
                                )
                                FriendRequestRow(
                                    username: "NeonShadow",
                                    mutualFriendsCount: 4,
                                    acceptAction: {},
                                    declineAction: {}
                                )
                            }
                            .padding(.horizontal, 24)
                        }
                        
                        // Online Friends Section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Online - 1")
                                .font(.otherTitle)
                                .foregroundColor(.panelDark)
                                .padding(.horizontal, 24)
                            
                            OnlineFriendRow(
                                username: "Kim Mingyu",
                                readingStatus: "My Friend is Zombie!"
                            )
                            .padding(.horizontal, 24)
                        }
                        
                        // Friends List Section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Friends List")
                                .font(.otherTitle)
                                .foregroundColor(.panelDark)
                                .padding(.horizontal, 24)
                            
                            VStack(spacing: 12) {
                                FriendsListRow(
                                    username: "Kim Mingyu",
                                    readingStatus: "My Friend is Zombie!",
                                    timeAgo: "10m ago"
                                )
                                FriendsListRow(
                                    username: "Kim Mingyu",
                                    readingStatus: "My Friend is Zombie!",
                                    timeAgo: "10m ago"
                                )
                                FriendsListRow(
                                    username: "Kim Mingyu",
                                    readingStatus: "My Friend is Zombie!",
                                    timeAgo: "10m ago"
                                )
                                FriendsListRow(
                                    username: "Kim Mingyu",
                                    readingStatus: "My Friend is Zombie!",
                                    timeAgo: "10m ago"
                                )
                            }
                            .padding(.horizontal, 24)
                            .padding(.bottom, 100) // Extra padding for the floating tab bar
                        }
                    }
                    .padding(.top, 8)
                }
            }
            .background(Color.white)
            .ignoresSafeArea(.all, edges: .top)
            // Hide the default navigation bar so it doesn't duplicate your custom header
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    FriendsPageView()
}
