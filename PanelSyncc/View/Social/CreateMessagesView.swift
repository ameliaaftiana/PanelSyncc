//
//  CreateMessagesView.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 21/06/26.
//


import SwiftUI

struct CreateMessagesView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchText: String = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(UIColor.systemGray6).ignoresSafeArea()
            
            VStack(spacing: 0) {
                // ── 1. Curved Top Header ─────────────────────────────────────
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                    }
                    
                    Spacer()
                    
                    Text("Create Messages")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    // Invisible placeholder for centering
                    Color.clear.frame(width: 44, height: 44)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .padding(.bottom, 12)
                
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
                .padding(.horizontal)
                .frame(height: 50)
                .background(Color.white)
                .cornerRadius(25)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                .padding(.horizontal)
                .padding(.top, 24)
                .padding(.bottom, 16)

                // ── 3. Friends List ──────────────────────────────────────────────
                VStack(alignment: .leading, spacing: 16) {
                    Text("Friends")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.horizontal)

                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 12) {
                            ForEach(0..<4, id: \.self) { _ in
                                // UPDATED: Wrapped in NavigationLink
                                NavigationLink(destination: ChatView()) {
                                    FriendSelectionCard(
                                        name: "Kim Mingyu",
                                        readingStatus: "Reading: My Friend is Zombie!"
                                    )
                                }
                                .buttonStyle(PlainButtonStyle()) // Prevents default blue link coloring
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Components

struct FriendSelectionCard: View {
    let name: String
    let readingStatus: String
    
    var body: some View {
        HStack(spacing: 16) {
            Circle()
                .fill(Color(white: 0.8))
                .frame(width: 56, height: 56)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                HStack(spacing: 4) {
                    Image(systemName: "book")
                        .font(.system(size: 10))
                    Text(readingStatus)
                        .font(.caption2)
                        .italic()
                }
                .foregroundColor(.white.opacity(0.8))
            }
            Spacer()
        }
        .padding(16)
        .background(Color.panelDark)
        .cornerRadius(16)
    }
}

#Preview {
    NavigationStack {
        CreateMessagesView()
    }
}
