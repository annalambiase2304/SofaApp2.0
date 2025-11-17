//
//  MenuItem.swift
//  SofaApp
//
//  Created by Anna Lambiase on 11/11/25.
//

import Combine
import SwiftUI

// 1. Enum per la selezione delle Tab (barra inferiore)
enum Tabs {
    case main, logbook, settings, search
}

// 2. Enum per le opzioni di creazione del bottone "+"
enum CreationOption: String, Identifiable {
    case items, newList, newGroup
    
    var id: String { self.rawValue }
    
    var title: String {
        switch self {
        case .items: return "Items"
        case .newList: return "New List"
        case .newGroup: return "New Group"
        }
    }
}

// Struttura per un Gruppo
struct ListGroup: Identifiable, Hashable {
    let id = UUID()
    var name: String
}

// Lista di Gruppi di Esempio + il gruppo predefinito "No Group"
let mockGroups: [ListGroup] = [
    ListGroup(name: "No Group"),
    ListGroup(name: "Projects"),
    ListGroup(name: "Personal")
]

// Struttura per un SINGOLO ELEMENTO (Es. "1984")
// 👈 QUESTO È IL NUOVO ELEMENTO FONDAMENTALE
struct ListItem: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var isChecked: Bool = false // Per la checklist
}

// Struttura per una Lista (Ora contiene un array di ListItem)
struct AppList: Identifiable, Hashable {
    let id = UUID()
    var name: String
    let iconName: String
    let color: Color
    var group: ListGroup?
    var items: [ListItem] = [] // 👈 MODIFICA: La lista ora ha elementi
}

// Classe Dati Osservabile

class AppData: ObservableObject {
    @Published var lists:[ AppList] = [
        AppList(name: "Apps to Check Out", iconName: "lightbulb", color: .blue.opacity(0.2), group: mockGroups.first!,
                items: [ListItem(name: "Sofa App (Questa!)"), ListItem(name: "Widget App Esempio")]),
        
        AppList(name: "Books to read", iconName: "book", color: .blue.opacity(0.2), group: mockGroups.first!,
                items: [ListItem(name: "Dune"), ListItem(name: "1984")]),
        
        AppList(name: "Games to play", iconName: "gamecontroller", color: .blue.opacity(0.2), group: mockGroups.first!,
                items: [ListItem(name: "Elden Ring")]),
        
        AppList(name: "Movies to watch", iconName: "popcorn", color: .blue.opacity(0.2), group: mockGroups.first!),
        
        AppList(name: "TV series to bingewatch", iconName: "popcorn", color: .blue.opacity(0.2), group: mockGroups.first!),
        
        AppList(name: "Boardgames to try", iconName: "popcorn", color: .blue.opacity(0.2), group: mockGroups.first!)
    ]

    @Published var groups: [ListGroup] = mockGroups

    // Metodo per aggiungere una nuova lista (ora crea una lista VUOTA di items)
    func addNewList(title: String, group: ListGroup) {
        let newList = AppList(
            name: title,
            iconName: "list.bullet.rectangle.fill",
            color: .blue.opacity(0.2),
            group: group.name == "No Group" ? nil : group,
            items: [] // Inizia con un array di elementi vuoto
        )
        lists.append(newList)
    }
}
