import SwiftUI

/// A type that provides a type-safe Analytics API that's backend agnostic
public struct Analytics: Sendable {
    private init() { }

    private static var observers: [ObjectIdentifier: WeakBox] = [:]

    /// Registers an observer that can respond to Analytics events.
    /// - Parameter observer: The observer that will respond to Analytics events
    public static func register(_ observer: AnalyticsObserver) {
        observers[ObjectIdentifier(observer)] = .init(object: observer) {
            unregister(observer)
        }
    }

    public static func unregister(_ observer: AnalyticsObserver) {
        observers[ObjectIdentifier(observer)] = nil
    }

    internal static func log(interaction: Interaction, values: AnalyticsValues) {
        observers.values.forEach {
            $0.object?.log(interaction: interaction, values: values)
        }
    }

    internal static func log(view: View, values: AnalyticsValues) {
        observers.values.forEach {
            $0.object?.log(view: view, values: values)
        }
    }
}

/// Represents an observer that can respond to Analytics events. Generally this would represent your backend (e.g Firebase, etc)
/// but you can also use this to provide logging and debugging features.
public protocol AnalyticsObserver: AnyObject, Sendable {
    /// A 'view' event was logged
    /// - Parameters:
    ///   - view: The 'view' event that was logged
    ///   - values: All associated values (parameters) that were logged as a part of this event
    func log(view: Analytics.View, values: AnalyticsValues)

    /// A 'interaction' event was logged
    /// - Parameters:
    ///   - interaction: The 'interaction' event that was logged
    ///   - values: All associated values (parameters) that were logged as a part of this event
    func log(interaction: Analytics.Interaction, values: AnalyticsValues)
}

private struct WeakBox: Sendable {
    private(set) weak var object: AnalyticsObserver? {
        didSet {
            guard object == nil else { return }
            onDeinit()
        }
    }

    var onDeinit: @Sendable () -> Void
}
