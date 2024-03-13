//
//  CharacterDetailPage.swift
//  RickAndMortyApp
//
//  Created by Goncalves Higino on 13/03/24.
//

import SwiftUI

struct CharacterDetailPage: View {
    @Environment(\.dismiss) var dismiss
    
    var character: CharacterBusinessModel?
    
    var body: some View {
        ScrollView {
            imageView
            detailView
        }
        .toolbar(.visible, for: .navigationBar)
        .background(Color("Background"))
        .ignoresSafeArea()
    }
    
    var imageView: some View {
        Group {
            if let character, let url = URL(string: character.image) {
                AsyncImageView(url: url)
            } else {
                Image("noImageAvailable")
            }
        }.overlay(alignment: .top) {
            closeBurronView
        }
        .frame(height: 400)
    }
    
    var closeBurronView: some View {
        ZStack {
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(.secondary)
                    .padding(8)
                    .background(.ultraThinMaterial)
                    .backgroundStyle(cornerRadius: 18)
            })
            .padding(15)
            .padding(.top)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
        .animation(.snappy, value: true)
    }
    
    
    
    var detailView: some View {
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .named("scroll")).minY
            
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: scrollY > 0 ? 500 + scrollY : 500)
            .overlay(
                VStack(alignment: .leading, spacing: 16) {
                    Text(character?.name ?? "")
                        .font(.title).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.primary)
                    
                    if let status = character?.status?.rawValue {
                        DetailTitleView(title: "Status: \(String(describing: status))".uppercased())
                    }
                    
                    if let species = character?.species {
                        DetailTitleView(title: "Species: \(String(describing: species))".uppercased())
                    }
                    
                    if let type = character?.type, !type.isEmpty {
                        DetailTitleView(title: "Type: \(String(describing: type))".uppercased())
                    }
                    
                    if let gender = character?.gender?.rawValue {
                        DetailTitleView(title: "Gender: \(String(describing: gender))".uppercased())
                    }
                    
                    if let origin = character?.origin.name {
                        DetailTitleView(title: "Origin: \(String(describing: origin))".uppercased())
                    }
                    
                    if let location = character?.location.name {
                        DetailTitleView(title: "Location: \(String(describing: location))".uppercased())
                    }
                    
                    if let listOfEpisodes = character?.listOfEpisodes {
                        DetailTitleView(title: "Episodes:")
                        
                        Text(listOfEpisodes)
                            .fontDetailTitle()
                        
                    }
                }
                    .padding(20)
                    .padding(.vertical, 10)
                    .background(
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .frame(maxHeight: .infinity, alignment: .bottom)
                            .cornerRadius(30)
                            .blur(radius: 30)
                    )
                    .background(
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .backgroundStyle(cornerRadius: 30)
                    )
                    .offset(y: scrollY > 0 ? -scrollY * 1.8 : 0)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .offset(y: 200)
                    .padding(20)
                )
            }
            .frame(height: 500)
        }
}


