import SwiftUI

// 1. MenuView: Il primo modale che appare con i 3 pulsanti
struct OptionsMenuView: View {
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
            .sheet(item: $secondaryOption) { option in
                switch option {
                case .items:
                    ItemsView (dismissParent: dismiss)
                case .newList:
                    NewListView(dismissParent: dismiss)
                case .newGroup:
                    NewGroupView(dismissParent: dismiss)
                }
                // NOTA: Il modale eredita automaticamente l'environmentObject dal genitore
            }
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
                    .fill(Color(.systemGray6)) // Corretto
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
    // 👈 1. MODIFICA: Usa @EnvironmentObject
    @EnvironmentObject var data: AppData
    
    let dismissParent: DismissAction
    @State private var title: String = ""
    @State private var selectedGroup: ListGroup = mockGroups.first!

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        TextField("Title", text: $title)
                            .autocorrectionDisabled(true)
                    }
                    Section(header: Text("Group")) {
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
                    Button("Cancel") { dismissParent() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Create") {
                        data.addNewList(title: title, group: selectedGroup)
                        dismissParent()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}

// 3. NewGroupView (Crea Nuovo Gruppo)
struct NewGroupView: View {
    // 👈 2. MODIFICA: Usa @EnvironmentObject
    @EnvironmentObject var data: AppData
    
    let dismissParent: DismissAction
    @State private var groupName: String = ""
    @Environment(\.dismiss) var dismiss

    var body: some View {
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
                    Button("Cancel") { dismissParent() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Create") {
                        let newGroup = ListGroup(name: groupName)
                        data.groups.append(newGroup)
                        dismissParent()
                    }
                    .disabled(groupName.isEmpty)
                }
            }
        }
    }
}

// 4. ItemsView (Aggiungi Elementi)
struct ItemsView: View {
    // 1. Riceve i dati centralizzati
    @EnvironmentObject var data: AppData
    
    // Azione per chiudere l'intero flusso modale (pulsante "Cancel")
    let dismissParent: DismissAction

    var body: some View {
        NavigationStack {
            List {
                // 2. Itera sulle TUE liste
                // Usiamo gli indici per ottenere il binding ($)
                ForEach(data.lists.indices, id: \.self) { index in
                    
                    // 3. NavigationLink passa il binding ($data.lists[index])
                    //    alla nuova AddItemView
                    NavigationLink(destination: AddItemView(list: $data.lists[index])) {
                        // Mostra l'icona e il nome della lista
                        HStack(spacing: 12) {
                            Image(systemName: data.lists[index].iconName)
                                .foregroundColor(.blue)
                                .frame(width: 20)
                            Text(data.lists[index].name)
                        }
                    }
                }
            }
            .navigationTitle("Add Item to List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    // Il pulsante "Cancel" ora chiude l'intero modale
                    Button("Cancel") { dismissParent() }
                }
            }
        }
    }
}

struct AddItemView: View {
    // Binding ($) alla lista che stiamo modificando (es. "Apps to Check Out")
    @Binding var list: AppList
    
    // Stato per il nome del nuovo item
    @State private var newItemName: String = ""
    
    // Per chiudere questa vista (e tornare a ItemsView)
    @Environment(\.dismiss) var dismiss
    let mainColor = Color.blue

    var body: some View {
        // Usiamo un Form per l'input
        Form {
            Section(header: Text("New Item Name")) {
                TextField("Es. 'Nuova App Fantastica'", text: $newItemName)
                    .autocorrectionDisabled(true)
            }
        }
        .navigationTitle("Add to \(list.name)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() } // Chiude solo questa vista
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Add") {
                    // 1. Crea il nuovo item
                    let newItem = ListItem(name: newItemName)
                    // 2. Aggiungilo all'array della lista (grazie al @Binding)
                    list.items.append(newItem)
                    // 3. Chiudi questa vista
                    dismiss()
                }
                .disabled(newItemName.isEmpty) // Disabilita se il testo è vuoto
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
                .presentationDetents([.fraction(0.30)])
        }
        // 👈 3. MODIFICA: Usa .environmentObject (risolve l'errore della riga 232)
        .environmentObject(AppData())
    }
}

#Preview {
    OptionsMenu_Preview()
}
