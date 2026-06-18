//
//  PrimaryButton.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 17/06/26.
//


import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.buttonFontOnboard)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color(hex:"171C26"))
                .cornerRadius(12)
                .padding(.horizontal, 10)
                .padding(.top, 10)
                .padding(.bottom)
        }
        
    }
}

// Preview
#Preview {
    PrimaryButton(title: "Get Started") {
        print("Tapped")
    }
    .padding()
}
