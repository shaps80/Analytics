import Foundation

/// A key for accessing values in the analytics
///
/// You can create custom analytics values by extending the
/// ``AnalyticsKey`` structure with new properties.
/// First declare a new key type and specify a value for the
/// required ``key`` property and ``Value`` type:
///
///     enum Source {
///         case contactList
///     }
///
///     private struct SourceAnalyticsKey: AnalyticsKey {
///         typealias Value = Source
///         static let key: String = "source"
///     }
///
/// Then use the key to define a new analytics value property:
///
///     extension AnalyticsValues {
///         var source: Source? {
///             get { self[SourceAnalyticsKey.self] }
///             set { self[SourceAnalyticsKey.self] = newValue }
///         }
///     }
///
/// - Note: `AnalyticsKey` has no default value requirement, because the default value for a key is always nil.
public protocol AnalyticsKey: Sendable {
    /// The associated type representing the type of the analytics key's value
    associatedtype Value: Sendable & CustomStringConvertible = String
    /// The string representation for this key that will be used in your analytics backend.
    static var key: String { get }
}

/// A collection of analytics values (parameters) propagated through a view hierarchy.
///
/// SwiftUI exposes a collection of values to your app's views in an
/// `EnvironmentValues` structure. To read a value from the structure,
/// declare a property using the ``Environment`` property wrapper and
/// specify the value's key path. For example, you can read the current locale:
///
///     @Environment(\.analyticsValues) private var values
///
public struct AnalyticsValues: Sendable {
    public private(set) var params: [String: Sendable & CustomStringConvertible] = [:]
    public init() { }

    /// Accesses the analytics value associated with a custom key.
    ///
    /// Create custom environment values by defining a key
    /// that conforms to the ``AnalyticsKey`` protocol, and then using that
    /// key with the subscript operator of the ``AnalyticsValues`` structure
    /// to get and set a value for that key:
    ///
    ///     enum Source {
    ///         case contactList
    ///     }
    ///
    ///     private struct SourceAnalyticsKey: AnalyticsKey {
    ///         typealias Value = Source
    ///         static let key: String = "source"
    ///     }
    ///
    /// You use custom analytics values by setting a value with the ``View/analytics(_:_:)`` view
    /// modifier, and reading values with the ``Environment`` property wrapper.
    ///
    ///     ContactDetailView()
    ///         .analytics(\.source, .contactList)
    ///
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

extension AnalyticsValues {
    internal mutating func appending(_ newValues: Self) {
        params.merge(newValues.params) { $1 }
    }
}
