import SwiftUI

private struct AnalyticsEnvironmentKey: EnvironmentKey, Sendable {
    public static var defaultValue: AnalyticsValues = .init()
}

public extension EnvironmentValues {
    /// A collection of analytics values (parameters) propagated through a view hierarchy.
    var analyticsValues: AnalyticsValues {
        get { self[AnalyticsEnvironmentKey.self] }
        set { self[AnalyticsEnvironmentKey.self] = newValue }
    }
}
