//
//  PersonSheetContentView.swift
//  CookieGame
//
//  Created by Marco Grimme on 07.06.24.
//

import SwiftUI

struct PersonSheetContentView: View {
    var name: String
    var age: Int
    var height: Double
    var weight: Double
    var eyeColor: String
    var birthDate: Date
    
    @Binding var isPresented: Bool // Binding zum Steuern des Zustands des Sheets
    
    var body: some View {
        VStack {
            Text("Personeninformationen")
                .font(.title)
                .padding()
            Divider()
            VStack(alignment: .leading, spacing: 8) {
                Text("Name: \(name)")
                Text("Alter: \(age)")
                Text("Größe: \(String(format: "%.0f", height)) cm")
                Text("Gewicht: \(String(format: "%.0f", weight)) kg")
                Text("Augenfarbe: \(eyeColor)")
                Text("Geburtsdatum: \(birthDate, formatter: dateFormatter)")
            }
            .padding()
            Button(action: {
                isPresented = false
            }) {
                Text("Abbrechen")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(6)
                    .padding(.horizontal, 30)
            }
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}

struct PersonSheetContentView_Previews: PreviewProvider {
    static var previews: some View {
        PersonSheetContentView(name: "Max", age: 25, height: 180, weight: 75, eyeColor: "Blau", birthDate: Date(), isPresented: .constant(true))
    }
}
