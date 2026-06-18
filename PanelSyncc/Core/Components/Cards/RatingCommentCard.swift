import SwiftUI

struct RatingCommentCard: View {
    let username: String
    let rating: Int // Controls how many stars are filled!
    let commentText: String
    let likes: Int
    let replies: Int
    
    // NEW: State variable to track if this comment is liked
    @State private var isLiked: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            // 1. Header (Avatar + Username + Stars)
            HStack(spacing: 12) {
                Circle()
                    .fill(Color.gray.opacity(0.8))
                    .frame(width: 44, height: 44)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(username)
                        .font(.commentsUsername)
                        .foregroundColor(.white)
                    
                    // Dynamic Star Rating
                    HStack(spacing: 4) {
                        ForEach(0..<5) { index in
                            // If index is less than the rating, fill it. Otherwise, leave it empty.
                            Image(systemName: index < rating ? "star.fill" : "star")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.yellow)
                        }
                    }
                }
                Spacer()
            }
            
            // 2. Comment Body Text
            Text(commentText)
                .font(.rankCardFontDescription)
                .foregroundColor(.white.opacity(0.9))
                .lineLimit(4)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            
            Spacer(minLength: 0)
            
            // 3. Footer Actions (Likes & Replies)
            HStack(spacing: 16) {
                Spacer()
                
                // UPDATED: Made the Likes section interactive
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        isLiked.toggle()
                    }
                }) {
                    HStack(spacing: 4) {
                        // Adds 1 to the total if isLiked is true
                        Text((likes + (isLiked ? 1 : 0)).abbreviated())
                            .foregroundColor(.white)
                        
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .foregroundColor(isLiked ? .red : .white)
                    }
                }
                
                // Replies
                HStack(spacing: 4) {
                    Text(replies.abbreviated())
                    Image(systemName: "text.bubble")
                }
                .foregroundColor(.white)
            }
            .font(.system(size: 14, weight: .bold))
        }
        .padding(16)
        .frame(width: 346, height: 160)
        .background(Color.panelDark)
        .cornerRadius(12)
    }
}

// Preview showing the dynamic stars in action
#Preview {
    ZStack {
        Color.white.ignoresSafeArea()
        
        VStack(spacing: 16) {
            RatingCommentCard(
                username: "Amelia Putri",
                rating: 5,
                commentText: "This chapter was amazing! I can't wait for the next one.",
                likes: 119,
                replies: 12
            )
            RatingCommentCard(
                username: "Critical Reader",
                rating: 3,
                commentText: "The art is good but the pacing of this chapter felt a bit rushed.",
                likes: 45,
                replies: 2
            )
        }
    }
}
