//
//  MenuItemRow.swift
//  SofaApp
//
//  Created by Anna Lambiase on 11/11/25.
//


import SwiftUI

// 1. Vista Personalizzata per la Riga del Menu
struct MenuItemRow: View {
    let item: MenuItem

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
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 10)

            Text(item.name)
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
    }
}

// 2. Vista di Dettaglio (la destinazione dopo il click)
struct DetailView: View {
    let menuItem: MenuItem

    var body: some View {
        VStack {
            Text("Lista per: \(menuItem.name)")
                .font(.title)
                .padding()
            Image(systemName: "list.bullet")
                .font(.largeTitle)
            Spacer()
        }
        .navigationTitle(menuItem.name)
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
    MenuItemRow(item: mainMenuItems.first!)
}
