//
//  MainContentView.swift
//  SofaApp
//
//  Created by Anna Lambiase on 11/11/25.
//


import SwiftUI

struct MainContentView: View {
   
    // Stato per gestire il modale
    @State private var selectedCreationOption: CreationOption? = nil
    let mainColor = Color(red: 0.2, green: 0.6, blue: 0.5)

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Intestazione
            Group {
                Text("Main")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(mainColor)
                Text("Let's organise your downtime!")
                    .font(.title3)
                    .padding(.bottom, 20)
            }
            .padding(.horizontal)

            // Contenuto scorrevole con le righe del menu
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(mainMenuItems) { item in
                        NavigationLink(destination: DetailView(menuItem: item)) {
                            MenuItemRow(item: item)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)
            }
            
            Spacer()
        }
        .navigationTitle("")
        .toolbar {
            // Pulsante "+" per aprire il menu di creazione
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    selectedCreationOption = .items // Trigger per aprire OptionsMenuView
                } label: {
                    Image(systemName: "plus")
                        .font(.headline)
                        .foregroundColor(mainColor)
                        .clipShape(Circle())
                }
            }
        }
        // Il foglio modale che presenta il menu di creazione
        .sheet(item: $selectedCreationOption) { option in
            OptionsMenuView(selectedOption: option)
            // 👈 AGGIUNGI QUESTO MODIFICATORE
                           .presentationDetents([.fraction(0.20)]) // Usa circa il 30% dello schermo in altezza
                           .presentationDragIndicator(.visible) // Aggiunge l'indicatore per trascinare il modale
                   
        }
    }
}


#Preview {
    ContainerView()    
}
