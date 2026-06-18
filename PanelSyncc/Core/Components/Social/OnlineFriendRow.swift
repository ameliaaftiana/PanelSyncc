//
//  OnlineFriendRow.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 19/06/26.
//


import SwiftUI

struct OnlineFriendRow: View {
    let username: String
    let readingStatus: String
    
    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .frame(width: 54, height: 54)
                .foregroundColor(.panelSecondary)
                .overlay(
                    Circle().stroke(Color.blue, lineWidth: 3)
                )
            
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
            
            Circle()
                .fill(Color.blue)
                .frame(width: 8, height: 8)
        }
        .padding()
        .background(Color.panelDark)
        .cornerRadius(12)
    }
}

#Preview {
    OnlineFriendRow(
        username: "Kim Mingyu",
        readingStatus: "My Friend is Zombie!"
    )
    .padding()
}
