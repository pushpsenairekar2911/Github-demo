
//
//  GHAsyncImage.swift
//  GHKit
//
//  Created by Pushpsen Airekar on 23/05/25.
//

import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    private let url: URL
    private var cache = URLCache.shared

    init(url: URL) {
        self.url = url
        loadImage()
    }

    private func loadImage() {
        let request = URLRequest(url: url)

        // Try cached response
        if let cachedResponse = cache.cachedResponse(for: request),
           let image = UIImage(data: cachedResponse.data) {
            self.image = image
            return
        }

        // Otherwise, fetch and cache
        URLSession.shared.dataTask(with: request) { data, response, _ in
            guard let data = data,
                  let response = response,
                  let image = UIImage(data: data) else { return }

            let cachedData = CachedURLResponse(response: response, data: data)
            self.cache.storeCachedResponse(cachedData, for: request)

            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}

public struct GHAsyncImage: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Image

    public init(url: URL, placeholder: Image = Image(systemName: "photo")) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
        self.placeholder = placeholder
    }

    public var body: some View {
        if let image = loader.image {
            Image(uiImage: image).resizable()
        } else {
            placeholder.resizable()
        }
    }
}
