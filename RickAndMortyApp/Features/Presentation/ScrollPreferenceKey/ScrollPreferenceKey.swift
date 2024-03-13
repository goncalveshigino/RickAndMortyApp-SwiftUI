//
//  ScrollPreferenceKey.swift
//  RickAndMortyApp
//
//  Created by Goncalves Higino on 13/03/24.
//

import SwiftUI


struct ScrollPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
