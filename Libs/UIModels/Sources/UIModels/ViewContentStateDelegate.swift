// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation

public protocol ViewContentStateDelegate: AnyObject {
    func didUpdate(with state: ViewContentState)
}
