//
//  MainContentView.swift
//  SofaApp
//
//  Created by Anna Lambiase on 11/11/25.
//


import SwiftUI

struct MainContentView: View {
    @EnvironmentObject var data: AppData
    // Stato per gestire il modale
    @State private var selectedCreationOption: CreationOption? = nil
    let mainColor = Color.blue

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
                    ForEach(data.lists.indices, id: \.self) { index in
                        // Passiamo il binding $data.lists[index]
                        NavigationLink(destination: DetailView(list: $data.lists[index])) {
                            // Passiamo l'item normale data.lists[index]
                            MenuItemRow(item: data.lists[index])
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)
            }
        }
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    selectedCreationOption = .items
                } label: {
                    Image(systemName: "plus")
                    .font(.system(size: 30))
                    .foregroundColor(.blue)
                }
                .buttonStyle(PlainButtonStyle())
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
 
