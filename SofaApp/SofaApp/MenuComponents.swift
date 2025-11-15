//
//  MenuItemRow.swift
//  SofaApp
//
//  Created by Anna Lambiase on 11/11/25.
//


import SwiftUI

// 1. Vista Personalizzata per la Riga del Menu
struct MenuItemRow: View {
    let item: AppList

    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(item.color)
                    .frame(width: 50, height: 50)
                
                Image(systemName: item.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.blue)
            }
            .padding(.trailing, 10)

            Text(item.name)
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
    }
}

struct DetailView: View {
    // Riceve ancora il binding, che è utile se vogliamo
    // aggiungere/eliminare items in futuro.
    @Binding var list: AppList
    let mainColor = Color.blue

    var body: some View {
        List {
            // 👈 MODIFICA: Iteriamo sugli items statici (non più $list.items)
            ForEach(list.items) { item in
                
                // 👈 SOSTITUITO: Rimosso il Toggle, usato un HStack
                HStack(spacing: 12) {
                    // Usiamo l'icona della lista genitore
                    Image(systemName: list.iconName)
                        .font(.callout) // Una dimensione media per l'icona
                        .foregroundColor(mainColor) // Colore blu
                        .frame(width: 20, alignment: .center) // Per allineare
                    
                    Text(item.name)
                }
            }
        }
        .navigationTitle(list.name)
        .toolbar {
            // (In futuro, potremmo aggiungere un pulsante "+" qui
            // per aggiungere nuovi items a QUESTA lista)
        }
    }
}

// 3. Viste vuote per Logbook e Settings
struct PlaceholderView: View {
    let title: String
    let icon: String
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.largeTitle)
                .padding()
            Text(title)
                .font(.title)
        }
        .navigationTitle(title)
    }
}

// Anteprima per il debugging (opzionale)
#Preview {
    MenuItemRow(item: AppData().lists.first!)
}
