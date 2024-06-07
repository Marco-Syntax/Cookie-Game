//
//  FormView.swift
//  CookieGame
//
//  Created by Marco Grimme on 07.06.24.
//

import SwiftUI
struct FormView: View {
    
    // State-Variablen zur Speicherung der Formularwerte.
    @State private var name = ""
    @State private var age = 30
    @State private var height: Double = 170
    @State private var weight: Double = 70
    @State private var eyeColor: EyeColor = .braun
    @State private var birthDate = Date()
    
    // State-Variablen zur Steuerung der Darstellung von Sheet und Alert.
    @State private var showingSheet = false
    @State private var showingAlert = false
    
    // State-Variable zur Speicherung der Hintergrundfarbe.
    @State private var backgroundColor = Color(.systemBackground)
    
    // Enum zur Definition der möglichen Augenfarben.
    enum EyeColor: String, CaseIterable {
        case blau, grün, braun
    }
    
    var body: some View {
        Form {
            Section(header: Text("Personeninformationen")) {
                TextField("Name", text: $name)
                Stepper("Alter: \(age)", value: $age, in: 0...150)
                
                VStack {
                    Slider(value: $height, in: 100...250, step: 1)
                    Text("Größe: \(String(format: "%.0f", height)) cm")
                }
                
                VStack {
                    Slider(value: $weight, in: 0...200, step: 1)
                    Text("Gewicht: \(String(format: "%.0f", weight)) kg")
                }
                
                Picker("Augenfarbe", selection: $eyeColor) {
                    ForEach(EyeColor.allCases, id: \.self) { farbe in
                        Text(farbe.rawValue).tag(farbe)
                    }
                }
                
                DatePicker("Geburtsdatum", selection: $birthDate, displayedComponents: .date)
                
                ColorPicker("Hintergrundfarbe", selection: $backgroundColor)
            }
            
            // Button zum Anzeigen eines Sheets.
            Button(action: {
                showingSheet = true
            }) {
                Text("Sheet anzeigen")
            }
            
            // Button zum Anzeigen eines Alerts.
            Button(action: {
                showingAlert = true
            }) {
                Text("Alert anzeigen")
            }
        }
        .scrollContentBackground(.hidden)
        .background(backgroundColor) // Setzt die Hintergrundfarbe.
        .sheet(isPresented: $showingSheet) {
            PersonSheetContentView(
                name: name,
                age: age,
                height: height,
                weight: weight,
                eyeColor: eyeColor.rawValue,
                birthDate: birthDate,
                isPresented: $showingSheet
            )
//            .presentationDetents([.large, .medium,.fraction(0.2)] )
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Personeninformationen"),
                message: Text(
                    "Name: \(name)\nAlter: \(age)\nGröße: \(String(format: "%.0f", height)) cm\nGewicht: \(String(format: "%.0f", weight)) kg\nAugenfarbe: \(eyeColor.rawValue.capitalized)\nGeburtsdatum: \(birthDate, formatter: dateFormatter)"
                ),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

// Formatter für das Geburtsdatum.
private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
