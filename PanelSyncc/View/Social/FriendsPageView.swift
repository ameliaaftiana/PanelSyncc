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

                        NavigationLink(destination: MessagesView()) {
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
                .padding(.horizontal)
                .padding(.top, 10)
                .padding(.bottom, 12)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {

                        // Search Bar
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
                        .padding(.bottom, 8)

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
                            .padding(.horizontal)

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
                            .padding(.horizontal)
                        }

                        // Online Friends Section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Online - 1")
                                .font(.otherTitle)
                                .foregroundColor(.panelDark)
                                .padding(.horizontal)

                            OnlineFriendRow(
                                username: "Kim Mingyu",
                                readingStatus: "My Friend is Zombie!"
                            )
                            .padding(.horizontal)
                        }

                        // Friends List Section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Friends List")
                                .font(.otherTitle)
                                .foregroundColor(.panelDark)
                                .padding(.horizontal)

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
                            .padding(.horizontal)
                            .padding(.bottom, 100)
                        }
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 30)
                }
            }
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
    }
}

#Preview {
    FriendsPageView()
}
