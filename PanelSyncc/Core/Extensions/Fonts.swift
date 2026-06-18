import SwiftUI

extension Font {
    
    // MARK: - Headings (Plus Jakarta Sans)
    // Plus Jakarta Sans usually has matching file names and PostScript names.
    
    static var heading1: Font {
        .custom("PlusJakartaSans-Bold", size: 28, relativeTo: .largeTitle)
    }
    
    static var heading2: Font {
        .custom("PlusJakartaSans-SemiBold", size: 22, relativeTo: .title)
    }
    
    static var heading3: Font {
        .custom("PlusJakartaSans-Medium", size: 18, relativeTo: .title3)
    }
    
    // MARK: - Body (Inter)
    // 🚨 Notice we removed "_18pt" here! This is the PostScript name.
    
    static var bodyText: Font {
        .custom("Inter-Regular", size: 16, relativeTo: .body)
    }
    
    static var bodyBold: Font {
        .custom("Inter-SemiBold", size: 16, relativeTo: .body)
    }
    
    static var captionText: Font {
        .custom("Inter-Medium", size: 12, relativeTo: .caption)
    }
    
    static var buttonFontOnboard: Font {
        .custom("PlusJakartaSans-SemiBold", size: 17, relativeTo: .caption)
    }
    
    //Comic Card
    static var comicCardPortraitTitle: Font {
        .custom("Inter-Bold", size: 14, relativeTo: .caption)
    }
    static var comicCardPortraitBody: Font {
        .custom("Inter-Medium", size: 11, relativeTo: .body)
    }
    
    //Top Picks
    static var cardTopPicksTitle: Font {
        .custom("Inter-Bold", size: 20, relativeTo: .caption)
    }
    static var cardTopPicksDescription: Font {
        .custom("Inter-Medium", size: 14, relativeTo: .caption)
    }
    
    //rank
    static var rankCardFont: Font {
        .custom("PlusJakartaSans-ExtraBold", size: 20, relativeTo: .caption)
    }
    static var rankCardFontRest: Font {
        .custom("PlusJakartaSans-ExtraBold", size: 14, relativeTo: .caption)
    }
    static var rankCardFontTitle: Font {
        .custom("PlusJakartaSans-ExtraBold", size: 18, relativeTo: .caption)
    }
    static var rankCardFontDescription: Font {
        .custom("Inter-Regular", size: 14, relativeTo: .caption)
    }
    
    //comicdetails
    static var chapterCardTItle: Font {
        .custom("PlusJakartaSans-ExtraBold", size: 14, relativeTo: .caption)
    }
    
    //comments card
    static var commentsUsername: Font {
        .custom("PlusJakartaSans-ExtraBold", size: 16, relativeTo: .caption)
    }
    
    //On boarding
    static var onboardingTitle: Font {
        .custom("PlusJakartaSans-ExtraBold", size: 32, relativeTo: .caption)
    }
    static var onboardingDescription: Font {
        .custom("Inter-Medium", size: 17, relativeTo: .caption)
    }
    static var onboardingSkip: Font {
        .custom("Inter-Bold", size: 12, relativeTo: .caption)
    }
    
    //Login
    static var loginTitle: Font {
        .custom("PlusJakartaSans-ExtraBold", size: 34, relativeTo: .caption)
    }
    
    //home
    static var topPicksTitle: Font {
        .custom("PlusJakartaSans-ExtraBold", size: 24, relativeTo: .caption)
    }
    static var otherTitle: Font {
        .custom("PlusJakartaSans-Bold", size: 18, relativeTo: .caption)
    }
    static var seeAll: Font {
        .custom("Inter-SemiBold", size: 14, relativeTo: .caption)
    }
    
    //library
    static var libraryTitle: Font {
        .custom("PlusJakartaSans-ExtraBold", size: 28, relativeTo: .caption)
    }
    static var libraryMenuSelected: Font {
        .custom("PlusJakartaSans-Bold", size: 16, relativeTo: .caption)
    }
    static var libraryMenuUnSelected: Font {
        .custom("PlusJakartaSans-SemiBold", size: 16, relativeTo: .caption)
    }
    
    //friend page
    static var friendName: Font {
        .custom("Inter-ExtraBold", size: 14, relativeTo: .caption)
    }
    static var friendDescription: Font {
        .custom("Inter-Italic", size: 8, relativeTo: .caption)
    }
    static var friendButton: Font {
        .custom("PlusJakartaSans-SemiBold", size: 10, relativeTo: .caption)
    }
    static var friendTime: Font {
        .custom("Inter-SemiBold", size: 8, relativeTo: .caption)
    }
}
