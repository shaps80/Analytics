import SwiftUI

private struct WeakBox: Sendable {
    private(set) weak var object: AnalyticsObserver? {
        didSet {
            guard object == nil else { return }
            onDeinit()
        }
    }

    var onDeinit: @Sendable () -> Void
}

public struct Analytics: Sendable {
    private init() { }

    private static var observers: [ObjectIdentifier: WeakBox] = [:]

    public static func register(_ observer: AnalyticsObserver) {
        observers[ObjectIdentifier(observer)] = .init(object: observer) {
            unregister(observer)
        }
    }

    public static func unregister(_ observer: AnalyticsObserver) {
        observers[ObjectIdentifier(observer)] = nil
    }

    internal static func log(_ interaction: Interaction, values: AnalyticsValues) {
        observers.values.forEach {
            $0.object?.log(interaction: interaction, values: values)
        }
    }

    internal static func log(_ view: View, values: AnalyticsValues) {
        observers.values.forEach {
            $0.object?.log(view: view, values: values)
        }
    }
}

public protocol AnalyticsObserver: AnyObject, Sendable {
    func log(view: Analytics.View, values: AnalyticsValues)
    func log(interaction: Analytics.Interaction, values: AnalyticsValues)
}
