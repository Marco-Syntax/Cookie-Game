//
//  CookieView.swift
//  CookieGame
//
//  Created by Marco Grimme on 07.06.24.
//

import SwiftUI


// Haupt-View für das Cookie-Spiel
struct CookieView: View {
        // Erstellen einer Instanz des ViewModels als StateObject
    @StateObject private var viewModel = CookieViewModel()
        var body: some View {
        NavigationStack {
            ZStack {
                // Hintergrund als Linearer Farbverlauf
                LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]),
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Titeltext mit Gradient-Farbverlauf und Schatten
                    Text("Cookie Game")
                        .font(.system(size: 40))
                        .fontWeight(.semibold)
                        .foregroundStyle(LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.red]),
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                        .shadow(color: Color.white.opacity(0.5), radius: 10, x: 0, y: 5)
                    
                    // Highscore-Anzeige mit buntem Gradient-Hintergrund und passender Schriftfarbe
                    Text("Highscore: \(viewModel.finalCounter)🏆")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .padding(6)
                        .background(LinearGradient(
                            gradient: Gradient(colors: [Color.orange, Color.pink]),
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                        .cornerRadius(10)
                        .foregroundColor(Color.white)
                        .shadow(color: Color.white.opacity(0.2), radius: 10, x: 0, y: 5)
                    
                    // Punktestand-Anzeige mit buntem Gradient-Hintergrund und passender Schriftfarbe
                    Text("Punkte: \(viewModel.counter) ")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(6)
                        .background(LinearGradient(
                            gradient: Gradient(colors: [Color.cyan, Color.purple]),
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                        .cornerRadius(10)
                        .foregroundColor(Color.white)
                        .shadow(color: Color.white.opacity(0.3), radius: 10, x: 0, y: 5)
                    
                    // Zeit-Anzeige mit buntem Gradient-Hintergrund und passender Schriftfarbe
                    Text("Zeit: \(viewModel.timeFormatted(viewModel.timeRemaining)) ⏱️")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .padding(6)
                        .background(LinearGradient(
                            gradient: Gradient(colors: [Color.yellow, Color.orange]),
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                        .cornerRadius(10)
                        .foregroundColor(Color.white)
                        .shadow(color: Color.white.opacity(0.3), radius: 10, x: 0, y: 5)
                    
                    // Start- und Stop-Button
                    HStack(spacing: 20) {
                        CustomButton(title: "Start", backgroundColor: .green, action: viewModel.startTimer)
                        CustomButton(title: "Stop", backgroundColor: .red, action: viewModel.stopTimer)
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                    
                    // Anzeige der Cookies
                    HStack {
                        ForEach(0..<5) { index in
                            Button(action: {
                                viewModel.counter += 1 // Erhöht den Punktestand bei Klick
                                viewModel.animateCookie(at: index) // Startet die Animation für das Cookie
                            }) {
                                Cookie(isAnimating: viewModel.isAnimating[index]) // Zeigt das Cookie an
                            }
                            .offset(x: viewModel.cookieOffsets[index].x, y: viewModel.cookieOffsets[index].y) // Setzt die Position des Cookies
                        }
                    }
                }
                .padding()
                .alert(isPresented: $viewModel.showAlert) { // Zeigt den Alert an, wenn showAlert wahr ist
                    Alert(title: Text("Punktescore"), message: Text("🍪 Dein Punktescore ist \(viewModel.finalCounter) 🍪"), dismissButton: .default(Text("OK")))
                }
            }
            .navigationBarItems(trailing:NavigationLink(destination: FormView()) { // Navigation zu den Einstellungen
                Image(systemName: "gear")
                    .imageScale(.large)
                    .font(.title)
            }
            )
        }
    }
}

#Preview {
    CookieView()
}
