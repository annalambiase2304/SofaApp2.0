//
//  SettingsView.swift
//  SofaApp
//
//  Created by Anna Lambiase on 12/11/25.
//

import SwiftUI

struct SettingsView: View {
    
    // Le sezioni "About" e i link legali
    let aboutItems = ["About Sofa", "Contact Us"]
    let legalItems = ["Privacy Policy", "Terms of Use"]
    
    var body: some View {
        NavigationStack {
            List {
                // Sezione 1: Informazioni e Contatti
                Section(header: Text("About")) {
                    ForEach(aboutItems, id: \.self) { item in
                        NavigationLink(destination: PlaceholderView(title: item, icon: "info.circle")) {
                            HStack {
                                Text(item)
                                Spacer()
                                // Icone decorative
                                if item == "Contact Us" {
                                    Image(systemName: "envelope")
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
                
                Section(header: Text("Legal")) {
                    ForEach(legalItems, id: \.self) { item in
                        NavigationLink(destination: PlaceholderView(title: item, icon: "doc.text")) {
                            Text(item)
                        }
                    }
                }
                
                Section {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0 (1)")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
            
        }
    }
}
#Preview {
    SettingsView()
}
