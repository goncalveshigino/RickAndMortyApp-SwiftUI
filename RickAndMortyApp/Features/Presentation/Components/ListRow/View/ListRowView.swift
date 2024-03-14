//
//  ListRowView.swift
//  RickAndMortyApp
//
//  Created by Goncalves Higino on 14/03/24.
//

import SwiftUI

struct ListRowView: View {
    var title: String = ""
    var image: String = ""
    
    var body: some View {
        HStack {
            if let url = URL(string: image) {
                AsyncImageView(url: url)
                    .frame(width: 36, height: 36)
                    .background(.ultraThinMaterial)
                    .mask(Circle())
                    .backgroundStyle(cornerRadius: 18)
            }
            
            Text(title)
                .fontWeight(.semibold)
            Spacer()
        }
    }
}

