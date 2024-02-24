// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation

extension Decodable {
    /// Creates new instance by decoding the given JSON String.
    /// - Parameters:
    ///    - JSONString: JSON String that would be decoded.
    init?(JSONString: String?) {
        guard let json = JSONString,
            let jsonData = json.data(using: .utf8),
            let anInstance = try? JSONDecoder().decode(Self.self, from: jsonData) else {
                return nil
        }
        self = anInstance
    }
}
