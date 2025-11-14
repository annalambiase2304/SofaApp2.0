//
//  MenuItem.swift
//  SofaApp
//
//  Created by Anna Lambiase on 11/11/25.
//


import SwiftUI

// 1. Dati per le righe scorrevoli
struct MenuItem: Identifiable {
    let id = UUID()
    let name: String
    let iconName: String
    let color: Color
}

let mainMenuItems = [
    MenuItem(name: "Apps to Check Out", iconName: "lightbulb", color: Color(red: 0.95, green: 0.9, blue: 0.8)),
    MenuItem(name: "Books to read", iconName: "book", color: Color(red: 0.95, green: 0.9, blue: 0.8)),
    MenuItem(name: "Games to play", iconName: "gamecontroller", color: Color(red: 0.95, green: 0.9, blue: 0.8)),
    MenuItem(name: "Movies to watch", iconName: "popcorn", color: Color(red: 0.95, green: 0.9, blue: 0.8)),
    MenuItem(name: "TV series to bingewatch", iconName: "popcorn", color: Color(red: 0.95, green: 0.9, blue: 0.8)),
    MenuItem(name: "Boardgames to try", iconName: "popcorn", color: Color(red: 0.95, green: 0.9, blue: 0.8))
]

// 2. Enum per la selezione delle Tab (barra inferiore)
enum Tabs { 
    case main, logbook, settings, search 
}

// 3. Enum per le opzioni di creazione del bottone "+"
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

// All'interno di DataModels.swift

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

struct AppList: Identifiable, Hashable {
    let id = UUID()
    var name: String
    let iconName: String
    let color: Color
    var group: ListGroup? // Gruppo a cui appartiene (opzionale)
}

@Observable
class AppData {
    // Le liste iniziali che vengono dalla tua "mainMenuItems"
    var lists: [AppList] = [
        AppList(name: "Apps to Check Out", iconName: "lightbulb", color: Color(red: 0.95, green: 0.9, blue: 0.8), group: mockGroups.first!),
        AppList(name: "Books to read", iconName: "book", color: Color(red: 0.95, green: 0.9, blue: 0.8), group: mockGroups.first!),
        AppList(name: "Games to play", iconName: "gamecontroller", color: Color(red: 0.95, green: 0.9, blue: 0.8), group: mockGroups.first!),
        AppList(name: "Movies to watch", iconName: "popcorn", color: Color(red: 0.95, green: 0.9, blue: 0.8), group: mockGroups.first!),
        AppList(name: "TV series to bingewatch", iconName: "popcorn", color: Color(red: 0.95, green: 0.9, blue: 0.8), group: mockGroups.first!),
        AppList(name: "Boardgames to try", iconName: "popcorn", color: Color(red: 0.95, green: 0.9, blue: 0.8), group: mockGroups.first!)
    ]

    var groups: [ListGroup] = mockGroups

    // Metodo per aggiungere una nuova lista
    func addNewList(title: String, group: ListGroup) {
        let newList = AppList(
            name: title,
            iconName: "list.bullet.rectangle.fill",
            color: Color(red: 0.95, green: 0.9, blue: 0.8),
            group: group.name == "No Group" ? nil : group // Seleziona nil se è "No Group"
        )
        lists.append(newList)
    }
}

