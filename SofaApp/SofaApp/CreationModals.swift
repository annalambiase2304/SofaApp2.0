import SwiftUI


// 1. MenuView: Il primo modale che appare con i 3 pulsanti
struct OptionsMenuView: View {
    // Questa è l'azione di chiusura per il modale radice (OptionsMenuView)
    @Environment(\.dismiss) var dismiss
    
    @State private var secondaryOption: CreationOption? = nil
    
    let selectedOption: CreationOption
    let mainColor = Color.blue

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HStack(spacing: 45) {
                    OptionButton(option: .items, mainColor: mainColor, action: { secondaryOption = .items })
                    OptionButton(option: .newList, mainColor: mainColor, action: { secondaryOption = .newList })
                    OptionButton(option: .newGroup, mainColor: mainColor, action: { secondaryOption = .newGroup })
                }
                .padding(.top, 10)
                
                Spacer()
            }
            .padding()
            // Presenta la schermata secondaria (che si espande)
            .sheet(item: $secondaryOption) { option in
                // Passiamo 'dismiss' (che è l'azione di chiusura di questo modale)
                // ai figli, che lo useranno come 'dismissParent'.
                switch option {
                case .items:
                    ItemsView (dismissParent: dismiss)
                case .newList:
                    NewListView(dismissParent: dismiss)
                case .newGroup:
                    NewGroupView(dismissParent: dismiss)
                }
            }
            // Inietta l'ambiente AppData anche ai modali secondari
        }
    }
}

// Sub-View per i Pulsanti (Items, New List, New Group)
struct OptionButton: View {
    let option: CreationOption
    let mainColor: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                Circle()
                    .fill(Color(red: 0.9, green: 0.9, blue: 0.9))
                    .frame(width: 70, height: 70)
                    .overlay {
                        Image(systemName: iconFor(option))
                            .foregroundColor(mainColor)
                    }
                
                Text(option.title)
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
        }
    }
    
    func iconFor(_ option: CreationOption) -> String {
        switch option {
        case .items: return "lightbulb.fill"
        case .newList: return "list.bullet.rectangle.fill"
        case .newGroup: return "folder.fill"
        }
    }
}

// 2. NewListView (Crea Nuova Lista)
struct NewListView: View {
    // Dati centralizzati per l'aggiunta e la selezione del gruppo
    @Environment(AppData.self) var data
    
    // Azione per chiudere l'intero flusso modale (passata da OptionsMenuView)
    let dismissParent: DismissAction
    
    @State private var title: String = ""
    @State private var selectedGroup: ListGroup = mockGroups.first! // Inizializzazione

    var body: some View {
        // 👈 CORREZIONE: Aggiunto NavigationStack
        NavigationStack {
            VStack {
                Form {
                    // Sezione Titolo
                    Section {
                        TextField("Title", text: $title)
                            .autocorrectionDisabled(true)
                    }
                    
                    // Sezione Gruppo (Utilizza Picker per la tendina)
                    Section(header: Text("Group")) {
                        // Carica i gruppi da AppData per vedere quelli nuovi
                        Picker("Select Group", selection: $selectedGroup) {
                            ForEach(data.groups) { group in
                                Text(group.name).tag(group)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(.navigationLink)
                    }
                }
            }
            .navigationTitle("New List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    // ANNULLA: Chiude l'intero stack modale
                    Button("Cancel") { dismissParent() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Create") {
                        // 1. Azione: Salva i dati
                        data.addNewList(title: title, group: selectedGroup)
                        
                        // 2. Azione: Chiudi l'intero stack
                        dismissParent()
                    }
                    .disabled(title.isEmpty)
                }
            }
        } // 👈 Fine del NavigationStack
    }
}


// 3. NewGroupView (Crea Nuovo Gruppo)
struct NewGroupView: View {
    // Dati centralizzati per l'aggiunta del gruppo
    @Environment(AppData.self) var data
    
    // Azione per chiudere l'intero flusso modale
    let dismissParent: DismissAction
    
    @State private var groupName: String = ""
    @Environment(\.dismiss) var dismiss // Non usato per azioni definitive

    var body: some View {
        // 👈 CORREZIONE: Aggiunto NavigationStack
        NavigationStack {
            VStack {
                Text("What would you like to call this new group?")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                
                Form {
                    Section {
                        TextField("Group Name", text: $groupName)
                            .autocorrectionDisabled(true)
                    }
                }
                
                Spacer()
            }
            .navigationTitle("New Group")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    // ANNULLA: Chiude l'intero stack modale
                    Button("Cancel") { dismissParent() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Create") {
                        // 1. Azione: Salva i dati
                        let newGroup = ListGroup(name: groupName)
                        data.groups.append(newGroup)
                        
                        // 2. Azione: Chiudi l'intero stack
                        dismissParent()
                    }
                    .disabled(groupName.isEmpty)
                }
            }
        } // 👈 Fine del NavigationStack
    }
}

// 4. ItemsView (Aggiungi Elementi)
struct ItemsView: View {
    // Azione per chiudere l'intero flusso modale
    let dismissParent: DismissAction
    
    let itemOptions = ["Apps", "Books", "Movies & Shows", "Music Albums", "Custom"]

    var body: some View {
        // Questa vista aveva GIA' il NavigationStack, per questo funzionava
        NavigationStack {
            List {
                ForEach(itemOptions, id: \.self) { item in
                    HStack {
                        Circle()
                            .fill(Color(.systemGray6))
                            .frame(width: 30, height: 30)
                        
                        Text(item)
                    }
                }
            }
            .navigationTitle("Items")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    // ANNULLA: Chiude l'intero stack modale
                    Button("Cancel") { dismissParent() }
                }
            }
        }
    }
}

// Anteprima per il debugging
struct OptionsMenu_Preview: View {
    @State private var showingModal = true
    
    var body: some View {
        ZStack {
            Text("Main Content Placeholder")
        }
        .sheet(isPresented: $showingModal) {
            OptionsMenuView(selectedOption: .items)
                .presentationDetents([.fraction(0.30)]) // Simula il modale a metà schermo
        }
        // Fornisce i dati necessari per l'anteprima (es. per il Picker)
        .environment(AppData())
    }
}

#Preview {
    OptionsMenu_Preview()
}
