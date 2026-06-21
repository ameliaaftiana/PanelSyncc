//
//  RoundedCornerShape.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 19/06/26.
//


import SwiftUI

// MARK: - Custom Rounded Corner Shape
/// Allows rounding specific corners (used for the top header)
struct RoundedCornerShape: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Profile Avatar Component
struct ProfileAvatarView: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Main Avatar Placeholder
            Circle()
                .fill(Color(white: 0.8))
                .frame(width: 120, height: 120)
            
            // Edit Badge
            ZStack {
                Circle()
                    .fill(Color(white: 0.25))
                    .frame(width: 32, height: 32)
                
                Image(systemName: "pencil")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
            }
            .offset(x: -4, y: -4)
        }
    }
}

// MARK: - Menu Row Component
struct ProfileMenuRow: View {
    let iconName: String?
    let title: String
    let showDivider: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                if let iconName = iconName {
                    Image(systemName: iconName)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(width: 24) // Ensures icons align perfectly
                }
                
                Text(title)
                    .font(.libraryMenuUnSelected)
                    .foregroundColor(.panelDark)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.panelDark)
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            
            if showDivider {
                Divider()
                    .background(Color.gray.opacity(0.3))
                    .padding(.horizontal, 20)
            }
        }
        .background(Color(white: 0.85)) // Light gray background
    }
}

// MARK: - Menu Group Container
struct ProfileMenuGroup<Content: View>: View {
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack(spacing: 0) {
            content
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: - Bottom Tab Bar Mock
struct FloatingTabBarMock: View {
    var body: some View {
        HStack(spacing: 12) {
            // Main Tab Pill
            HStack {
                TabBarIcon(icon: "house", title: "Home", isActive: false)
                Spacer()
                TabBarIcon(icon: "books.vertical", title: "Library", isActive: false)
                Spacer()
                TabBarIcon(icon: "person.3", title: "Friends", isActive: false)
                Spacer()
                TabBarIcon(icon: "person.fill", title: "Profile", isActive: true)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(Color(white: 0.2))
            .clipShape(Capsule())
            
            // Search Button
            Button(action: {}) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(Color(white: 0.2))
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal, 16)
    }
}

private struct TabBarIcon: View {
    let icon: String
    let title: String
    let isActive: Bool
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: isActive ? .bold : .regular))
            Text(title)
                .font(.system(size: 10, weight: .bold))
        }
        .foregroundColor(isActive ? .blue : .gray)
    }
}
