
import Foundation
import SwiftUI


struct RemoteImage: View {
    let url: URL?
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
            }
        }
        .onAppear {
            if let url = url {
                imageLoader.loadImage(from: url)
            }
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let cache = ImageCache()
    private var task: URLSessionDataTask?
    
    func loadImage(from url: URL) {
        if let cachedImage = cache.get(forKey: url.absoluteString) {
            image = cachedImage
            return
        }
        task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = image
                self.cache.set(forKey: url.absoluteString, image: image)
            }
        }
        task?.resume()
    }
}


struct ImageView: View {
    let image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            
            .resizable()
            .scaledToFit()
    }
}
