//
//  RecentSearchRow.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 19/06/26.
//


import SwiftUI

struct RecentSearchRow: View {
    let text: String
    let onDelete: () -> Void
    
    var body: some View {
        HStack {
            Text(text)
                .font(.searchText)
                .foregroundColor(.white)
            
            Spacer()
            
            Button(action: onDelete) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .medium))
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 34) // Matching your Figma dimensions
        .background(Color.panelDark)
        .cornerRadius(8)
    }
}

#Preview {
    VStack {
        RecentSearchRow(text: "Fantasy", onDelete: {})
        RecentSearchRow(text: "Romance", onDelete: {})
    }
    .padding()
}
