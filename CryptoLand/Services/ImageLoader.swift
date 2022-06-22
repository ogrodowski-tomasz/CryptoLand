//
//  ImageLoader.swift
//  asyncCrypto
//
//  Created by Tomasz Ogrodowski on 22/06/2022.
//

import Foundation
import UIKit

private let _imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading = false

    var imageCache = _imageCache

    func loadImage(with url: URL) async {

        let urlString = url.absoluteString

        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            print("Fetching image from cache")
            self.image = imageFromCache
            return
        }

        Task { [weak self] in
            guard let self = self else { return }
            print("Fetching image from network on thread: \(Thread.current)")
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else { return }
                self.imageCache.setObject(image, forKey: urlString as AnyObject)

                await MainActor.run(body: { [weak self] in
                    self?.image = image
                })

            } catch {
                print(error)
            }
        }
    }
}
