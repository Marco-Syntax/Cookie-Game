//
//  CookieViewModel.swift
//  CookieGame
//
//  Created by Marco Grimme on 07.06.24.
//

import SwiftUI
import Combine
// ViewModel für das Cookie-Spiel
class CookieViewModel: ObservableObject {
    
    @Published var counter: Int = 0 // Punktestand des Spielers
    @Published var cookieOffsets: [(x: CGFloat, y: CGFloat)] = Array(repeating: (0, -310), count: 5) // Positionen der Cookies
    @Published var isAnimating: [Bool] = Array(repeating: false, count: 5) // Animationszustände der Cookies
    @Published var timeRemaining: Int = 60 // Verbleibende Spielzeit
    @Published var isTimerRunning: Bool = false // Zustand des Timers
    @Published var showAlert: Bool = false // Steuerung des Alerts
    @Published var finalCounter: Int = 0 // Endpunktestand
    
    private var timer: Timer? // Timer für das Spiel
    
    // Funktion zum Starten des Timers
    func startTimer() {
        guard !isTimerRunning else { return } // Startet den Timer nur, wenn er nicht bereits läuft
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1 // Verbleibende Zeit verringern
                for index in 0..<5 {
                    self.animateCookie(at: index) // Startet die Animation für alle Cookies
                }
            } else {
                self.stopTimer() // Stoppt den Timer, wenn die Zeit abgelaufen ist
            }
        }
        isTimerRunning = true // Setzt den Timer-Zustand auf laufend
    }
    
    // Funktion zum Stoppen des Timers
    func stopTimer() {
        guard isTimerRunning else { return } // Stoppt den Timer nur, wenn er läuft
        
        timer?.invalidate() // Invalidiert den Timer
        isTimerRunning = false
        finalCounter = counter // Speichert den aktuellen Punktestand
        showAlert = true // Zeigt den Alert an
        resetGame() // Setzt das Spiel zurück
    }
    
    // Funktion zum Zurücksetzen des Spiels
    private func resetGame() {
        counter = 0 // Setzt den Punktestand zurück
        timeRemaining = 60 // Setzt die verbleibende Zeit zurück
        resetCookiePositions() // Setzt die Positionen der Cookies zurück
    }
    
    // Funktion zum Zurücksetzen der Cookie-Positionen
    private func resetCookiePositions() {
        cookieOffsets = Array(repeating: (0, -310), count: 5) // Setzt alle Cookies auf ihre Startpositionen
    }
    
    // Funktion zum Animieren eines bestimmten Cookies
    func animateCookie(at index: Int) {
        isAnimating[index] = true // Setzt die Animation auf true
        setCookieOffset(for: index) // Setzt die neue Position des Cookies
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.isAnimating[index] = false // Setzt die Animation nach 0.5 Sekunden zurück
        }
    }
    
    // Funktion zum Setzen einer neuen zufälligen Position für ein bestimmtes Cookie
    private func setCookieOffset(for index: Int) {
        cookieOffsets[index] = (
            x: CGFloat.random(in: -30...30), // Zufällige x-Position
            y: CGFloat.random(in: -400...50) // Zufällige y-Position
        )
    }
    
    // Funktion zum Formatieren der verbleibenden Zeit als Minuten:Sekunden
    func timeFormatted(_ totalSeconds: Int) -> String {
        let minutes: Int = totalSeconds / 60
        let seconds: Int = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
