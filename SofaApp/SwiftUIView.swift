//
//  SwiftUIView.swift
//  SofaApp
//
//  Created by Anna Lambiase on 14/11/25.
//

import SwiftUI

struct SwiftUIView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            
            VStack{
                Rectangle()
                    .frame(width: 60, height: 40)
//                    .foregroundColor((colorScheme == .dark) ? Color.darkButton : Color.lightButton)
                    .foregroundStyle(.red).opacity(0.9)
                
            }
        }
    }
}

#Preview {
    SwiftUIView()
}
