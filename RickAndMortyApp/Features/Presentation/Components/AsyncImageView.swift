//
//  AsyncImageView.swift
//  RickAndMortyApp
//
//  Created by Goncalves Higino on 13/03/24.
//

import SwiftUI
import UIKit

struct AsyncImageView: View {
    let url: URL
    
    @State private var image: UIImage?
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
            } else {
                ProgressView()
                    .accentColor(.red)
            }
        }
        .onAppear {
            Task {
                do {
                    image = try await downloadImage(url: url)
                } catch {
                    Text("Mostrar imagem de error")
                }
            }
        }
    }
    
    private func downloadImage(url: URL) async throws -> UIImage {
        let cache = DefaultNSCacheStoreDatasource<String, UIImage>()
        
        if let cacheImage = cache[url.absoluteString] {
            return cacheImage
        }
        
        do {
           let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                cache[url.absoluteString] = image
                return image
            }
        } catch {
            throw ImageError.downloadFailed
        }
        
        throw ImageError.downloadFailed
    }
    
    enum ImageError: Error {
        case downloadFailed
    }
}

