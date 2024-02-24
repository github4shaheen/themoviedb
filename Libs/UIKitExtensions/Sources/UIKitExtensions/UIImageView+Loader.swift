// The Swift Programming Language
// https://docs.swift.org/swift-book


import UIKit
import ImageLoader

public extension UIImageView {
    func loadImage(with urlString: String?) {
        ImageLoader.loader.load(from: urlString, for: self)
    }
    
    func cancelImageLoad() {
        ImageLoader.loader.cancel(for: self)
    }
}
