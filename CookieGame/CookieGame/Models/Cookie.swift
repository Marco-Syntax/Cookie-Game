//
//  Cookie.swift
//  CookieGame
//
//  Created by Marco Grimme on 07.06.24.
//

import Foundation
import SwiftUI

struct Cookie: View {
    var isAnimating: Bool
    
    var body: some View {
        Image("CookieImage")
            .resizable()
            .frame(width: 60, height: 60)
            .aspectRatio(contentMode: .fit)
            .rotationEffect(.degrees(isAnimating ? 360 : 0)) // Vollständige Drehung, wenn animiert
            .scaleEffect(isAnimating ? 1.8 : 1) // Größere Skalierung, wenn animiert
            .animation(.easeInOut(duration: 0.8), value: isAnimating) // Sanfte Ein- und Aus-Animation
    }
}
