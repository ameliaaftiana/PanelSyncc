//
//  FriendsListRow.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 19/06/26.
//


import SwiftUI

struct FriendsListRow: View {
    let username: String
    let readingStatus: String
    let timeAgo: String
    
    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .frame(width: 54, height: 54)
                .foregroundColor(.panelSecondary)
            
            VStack(alignment: .leading) {
                Text(username)
                    .font(.friendName)
                    .foregroundColor(.white)
                
                HStack(spacing: 4) {
                    Image(systemName: "book.fill")
                        .font(.system(size: 8))
                    Text("Reading: \(readingStatus)")
                }
                .font(.friendDescription)
                .foregroundColor(.panelSecondary)
            }
            
            Spacer()
            
            Text(timeAgo)
                .font(.friendTime)
                .foregroundColor(.white)
                .padding(.top, -10)
        }
        .padding()
        .background(Color.panelDark)
        .cornerRadius(12)
    }
}

#Preview {
    FriendsListRow(
        username: "Kim Mingyu",
        readingStatus: "My Friend is Zombie!",
        timeAgo: "10m ago"
    )
    .padding()
}
