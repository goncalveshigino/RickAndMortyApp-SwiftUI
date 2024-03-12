//
//  BackgroundColorModifier.swift
//  RickAndMortyApp
//
//  Created by Goncalves Higino on 12/03/24.
//

import Foundation


import SwiftUI

extension View {
    func backgroundColor(opacity: Double = 0.6) -> some View {
        self.modifier(BackgroundColor(opacity: opacity))
    }
}

struct BackgroundColor: ViewModifier {
    var opacity: Double = 0.6
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Color("Background")
                    .opacity(colorScheme == .dark ? opacity : 0)
                    .blendMode(.overlay)
                    .allowsHitTesting(false)
            )
    }
}
