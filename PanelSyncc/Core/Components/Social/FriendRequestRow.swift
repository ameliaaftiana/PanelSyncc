//
//  FriendRequestRow.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 19/06/26.
//


import SwiftUI

struct FriendRequestRow: View {
    let username: String
    let mutualFriendsCount: Int
    let acceptAction: () -> Void
    let declineAction: () -> Void
    
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
                    Image(systemName: "person.2.fill")
                        .font(.system(size: 8))
                    Text("\(mutualFriendsCount) Mutual Friends")
                }
                .font(.friendDescription)
                .foregroundColor(.panelSecondary)
            }
            
            Spacer()
            
            Button(action: acceptAction) {
                Text("Accept")
                    .font(.friendButton)
                    .foregroundColor(.panelDark)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.panelSecondary)
                    .cornerRadius(8)
            }
            
            Button(action: declineAction) {
                Image(systemName: "xmark")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.panelDark)
                    .padding(8)
                    .background(Color.panelSecondary)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.panelDark)
        .cornerRadius(12)
    }
}

#Preview {
    FriendRequestRow(
        username: "NeonShadow",
        mutualFriendsCount: 4,
        acceptAction: { print("Accepted") },
        declineAction: { print("Declined") }
    )
    .padding()
}
