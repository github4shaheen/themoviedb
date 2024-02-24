// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation
import TMDBRepo
import UIKit

public class TrendingRouter {
   
    public static func assemble() -> UIViewController {
        let repo = TrendingRepo()
        let viewModel = TrendingViewModel(repo: repo)
        let controller = TrendingViewController(viewModel: viewModel)
        return controller
    }
}

