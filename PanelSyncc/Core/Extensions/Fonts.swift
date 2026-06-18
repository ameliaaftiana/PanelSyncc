//
//  Fonts.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 17/06/26.
//

import SwiftUI

extension Font {
    
    // MARK: - Headings (Plus Jakarta Sans)
    
    /// Used for large page titles (e.g., Onboarding, Home Header)
    static var heading1: Font {
        // Anchors a 28pt custom font to Apple's .largeTitle scale behavior
        .custom("PlusJakartaSans-Bold", size: 28, relativeTo: .largeTitle)
    }
    
    /// Used for section titles (e.g., "Top Picks", "Trending")
    static var heading2: Font {
        .custom("PlusJakartaSans-SemiBold", size: 22, relativeTo: .title)
    }
    
    /// Used for sub-headings or card titles
    static var heading3: Font {
        .custom("PlusJakartaSans-Medium", size: 18, relativeTo: .title3)
    }
    
    // MARK: - Body (Inter)
    
    /// Used for standard paragraph text, descriptions, and main reading content
    static var bodyText: Font {
        // Anchors a 16pt custom font to Apple's .body scale behavior
        .custom("Inter-Regular", size: 16, relativeTo: .body)
    }
    
    /// Used for slightly emphasized body text
    static var bodyBold: Font {
        .custom("Inter-SemiBold", size: 16, relativeTo: .body)
    }
    
    /// Used for tags, timestamps, and secondary information
    static var captionText: Font {
        .custom("Inter-Medium", size: 12, relativeTo: .caption)
    }
    
    /// Used for buttons in onboarding
    static var buttonFontOnboard: Font {
        .custom("PlusJakartaSans-SemiBold", size: 17, relativeTo: .caption)
    }
}
