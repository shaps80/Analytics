import Foundation

public protocol AnalyticsKey: Sendable {
    associatedtype Value: Sendable = String
    static var key: String { get }
}

public struct AnalyticsValues: Sendable {
    public private(set) var params: [String: Sendable] = [:]
    public init() { }

    public subscript<K>(key: K.Type) -> K.Value? where K: AnalyticsKey {
        get { params[K.key] as? K.Value }
        set { params[K.key] = newValue }
    }
}

extension AnalyticsValues: CustomStringConvertible {
    public var description: String {
        params
            .sorted { $0.key < $1.key }
            .map { "\($0.key): \($0.value)" }
            .joined(separator: " | ")
    }
}

extension AnalyticsValues: CustomDebugStringConvertible {
    public var debugDescription: String {
        params
            .sorted { $0.key < $1.key }
            .map { "- \($0.key): \($0.value)" }
            .joined(separator: "\n")
    }
}
