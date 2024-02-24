// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation

public class Cache<T: AnyObject> {
    private var cache: NSCache<NSString, T>

    public init() {
        cache = NSCache<NSString, T>()
    }

    public func save(_ obj: T, forKey key: String) {
        cache.setObject(obj, forKey: NSString(string: key))
    }

    public func retrieve(from key: String) -> T? {
        cache.object(forKey: NSString(string: key))
    }
}
