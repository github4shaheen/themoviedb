// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation
import TMDBRepo
import UIKit

public class MovieDetailsRouter {
   
    public static func assemble(id: Int) -> UIViewController {
        let repo = MovieDetailsRepo()
        let viewModel = MovieDetailsViewModel(id: id, repo: repo)
        let controller = MovieDetailsViewController(viewModel: viewModel)
        return controller
    }
}

