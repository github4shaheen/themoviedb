// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public enum ViewContentState: Equatable {
    case started
    case populated
    case loading
    case error(text: String, description: String?, actionTitle: String?)
}
