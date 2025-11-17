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
                        Text ("Your research")
                    }
                    .navigationTitle("Search")
                    .searchable (text: $searchString)
                }
            }
        }
        .tint(.blue)
        .environmentObject(appData)
    }
}

 
#Preview {
    ContainerView()
        .environmentObject(AppData()) 
}
