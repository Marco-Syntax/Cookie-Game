//
//  CustomButton.swift
//  CookieGame
//
//  Created by Marco Grimme on 07.06.24.
//

import Foundation

import SwiftUI
struct CustomButton: View {
    var title: String
    var backgroundColor: Color
    var action: () -> Void  // Ein Closure, das eine Funktion für die Aktion beim Drücken eines Buttons wie StartTimer() oder StopTimer() erwartet
    var body: some View {
        Button(action: action) {
            Text(title)
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
                .background(backgroundColor)
                .foregroundStyle(.white)
                .cornerRadius(6)
                .shadow(color: Color.black.opacity(0.6), radius: 4, x: 0, y: 2)
        }
    }
}
