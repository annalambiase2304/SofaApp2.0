//
//  ContainerView.swift
//  SofaApp
//
//  Created by Anna Lambiase on 12/11/25.
//

import SwiftUI

struct ContainerView: View {
    @StateObject private var appData = AppData()
    
    @State var selectedTab: Tabs = .main
    @State var searchString = ""
    
    var body: some View {
        TabView (selection: $selectedTab) {
            // ... (La tua Tab "Main") ...
            Tab ("Main", systemImage: "house", value: .main) {
                NavigationStack {
                    MainContentView ()
                }
            }
            
            Tab ("Logbook", systemImage: "note.text", value: .logbook) {
                NavigationStack {
                    LogbookView()
                   
                }
            }
            Tab ("Settings", systemImage: "gear", value: .settings){
                SettingsView()
            }
            Tab (value: .search, role: .search) {
                NavigationStack {
                    List {
                        Text ("Type your research here")
                    }
                    .navigationTitle("Search")
                    .searchable (text: $searchString)
                }
            }
        }
        .tint(.blue)
        // 👈 2. INIETTA L'UNICA FONTE DI VERITÀ
        .environmentObject(appData)
    }
}

 
#Preview {
    ContainerView()
        .environmentObject(AppData()) // La preview ha bisogno della sua copia
}
