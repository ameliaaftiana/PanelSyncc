import SwiftUI

struct ComicReadingView: View {
    let chapterNumber: Int
    @Environment(\.dismiss) private var dismiss
    
    @State private var isLoved: Bool = false
    
    var body: some View {
        ZStack {
            // ── 1. Main Comic Content (Black Background) ───────────────────
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // Placeholder for long vertical comic panels
                    ForEach(0..<5, id: \.self) { _ in
                        Rectangle()
                            .fill(Color.black)
                            // Giving it a tall height to simulate long panels
                            .frame(height: 800)
                    }
                }
            }
            .ignoresSafeArea()
            .background(Color.black)
            
            // ── 2. Overlay Toolbars ─────────────────────────────────────────
            VStack {
                // Top Navigation Bar
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(14)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                    
                    Spacer()
                    
                    Text("Chapter \(chapterNumber)")
                        .font(.rankTitle)
                        .foregroundColor(.panelDark)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation { isLoved.toggle() }
                    }) {
                        Image(systemName: isLoved ? "heart.fill" : "heart")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(isLoved ? .red : .black)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 56)
                .padding(.bottom, 16)
                .background(Color.panelSecondary) // UPDATED HERE
                
                Spacer()
                
                // Bottom Toolbar
                HStack {
                    Spacer()
                    Button(action: {
                        // TODO: Toggle Light/Dark Mode
                    }) {
                        Image(systemName: "sun.max")
                            .font(.system(size: 22))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        Button(action: {
                            // TODO: Go to Previous Chapter
                        }) {
                            Image(systemName: "backward.end")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.panelDark)
                                .frame(width: 54, height: 54)
                                // 1. The frosted glass background
                                .background(.ultraThinMaterial)
                                .clipShape(Circle())
                                // 2. The light-catching rim
                                .overlay(
                                    Circle()
                                        .stroke(Color.white.opacity(0.6), lineWidth: 0)
                                )
                                // 3. The soft drop shadow for depth
                                .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
                        }
                        
                        Button(action: {
                            // TODO: Open Chapter List
                        }) {
                            Image(systemName: "list.bullet")
                                .font(.system(size: 28, weight: .semibold))
                                .foregroundColor(.panelDark)
                                .frame(width: 72, height: 72)
                                .background(.ultraThinMaterial)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.white.opacity(0.6), lineWidth: 0)
                                )
                                .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
                        }
                        
                        Button(action: {
                            // TODO: Go to Next Chapter
                        }) {
                            Image(systemName: "forward.end")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.panelDark)
                                .frame(width: 54, height: 54)
                                .background(.ultraThinMaterial)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.white.opacity(0.6), lineWidth: 0)
                                )
                                .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // TODO: Open Settings
                    }) {
                        Image(systemName: "gearshape")
                            .font(.system(size: 22))
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 34) // Account for the home indicator
                .background(Color.panelSecondary) // UPDATED HERE
            }
            .ignoresSafeArea()
        }
        .navigationBarHidden(true) // Hides the default nav bar so our custom one shows
    }
}

#Preview {
    ComicReadingView(chapterNumber: 10)
}
