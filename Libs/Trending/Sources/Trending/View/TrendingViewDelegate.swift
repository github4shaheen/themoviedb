// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import UIModels

protocol TrendingViewDelegate: AnyObject, ViewContentStateDelegate {
    func navigateToMovieDetailsView(with id: Int)
    func reload(indexPaths: [IndexPath])
}
