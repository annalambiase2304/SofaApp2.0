//
//  LogbookView.swift
//  SofaApp
//
//  Created by Anna Lambiase on 12/11/25.
//

import SwiftUI

struct LogbookView: View {
    let mainColor = Color(red: 0.2, green: 0.6, blue: 0.5)

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Intestazione
            Group {
                Text("Logbook")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(mainColor)
                Text("A log of how you’ve spent your downtime.")
                    .font(.title3)
                    .padding(.bottom, 20)
            }
            .padding(.horizontal)
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
           
        }
        Spacer()
    }
}
#Preview {
    LogbookView()
}
