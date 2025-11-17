//
//  LogbookView.swift
//  SofaApp
//
//  Created by Anna Lambiase on 12/11/25.
//

import SwiftUI

struct LogbookView: View {
    @EnvironmentObject var data: AppData
    let mainColor = Color.blue

    var body: some View {
        List {
            ForEach(data.lists.indices, id: \.self) { listIndex in
                let list = data.lists[listIndex]
                
                if !list.items.isEmpty {
                    Section(header: Text(list.name)) {
                        
                        ForEach(list.items.indices, id: \.self) { itemIndex in
                            
                            let isCheckedBinding = $data.lists[listIndex].items[itemIndex].isChecked
                            let itemName = data.lists[listIndex].items[itemIndex].name
                            
                            // Checkbox personalizzata
                            Button(action: {
                                isCheckedBinding.wrappedValue.toggle()
                            }) {
                                HStack(spacing: 10) {
                                    Image(systemName: isCheckedBinding.wrappedValue ? "checkmark.square.fill" : "square")
                                        .font(.title3)
                                        .foregroundColor(mainColor)
                                    
                                    Text(itemName)
                                        .foregroundColor(.primary)
                                    
                                    Spacer()
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Logbook")
    }
}

#Preview {
    NavigationStack {
        LogbookView()
    }
    .environmentObject(AppData())
}
