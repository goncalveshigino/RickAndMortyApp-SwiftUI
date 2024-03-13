//
//  DetailTitle.swift
//  RickAndMortyApp
//
//  Created by Goncalves Higino on 13/03/24.
//

import SwiftUI

struct DetailTitleView: View {
    var title: String
    
    var body: some View {
        Text(title)
            .fontDetailTitle()
    }
}


struct DetailTitle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.footnote).bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.primary.opacity(0.7))
        
        Divider()
            .foregroundStyle(.secondary)
    }
}

extension View {
    func fontDetailTitle() -> some View {
        self.modifier(DetailTitle())
    }
}
