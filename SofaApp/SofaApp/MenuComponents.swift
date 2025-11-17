//
//  MenuItemRow.swift
//  SofaApp
//
//  Created by Anna Lambiase on 11/11/25.
//


import SwiftUI

//Vista Personalizzata per la Riga del Menu
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
    // aggiungere/eliminare items in futuro.
    @Binding var list: AppList
    let mainColor = Color.blue

    var body: some View {
        List {
            ForEach(list.items) { item in
                
                HStack(spacing: 12) {
                    Image(systemName: list.iconName)
                        .font(.callout)
                        .foregroundColor(mainColor)
                        .frame(width: 20, alignment: .center) 
                    
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

// Viste vuote per Logbook e Settings
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

#Preview {
    MenuItemRow(item: AppData().lists.first!)
}
