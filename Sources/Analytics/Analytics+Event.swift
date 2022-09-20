import Foundation

/// A type to represent an analytics event.
///
/// Generally you define your own types:
///
///     public struct ViewEvent: AnalyticsEvent {
///         public var name: String { "view" }
///     }
///
///     extension AnalyticsEvent where Self == ViewEvent {
///         static var view: Self { .init() }
///     }
public protocol AnalyticsEvent {
    var name: String { get }
}
