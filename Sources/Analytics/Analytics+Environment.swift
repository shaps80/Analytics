import SwiftUI

public struct AnalyticsEnvironmentKey: EnvironmentKey, Sendable {
    public static var defaultValue: AnalyticsValues = .init()
}

public extension EnvironmentValues {
    var analyticsValues: AnalyticsValues {
        get { self[AnalyticsEnvironmentKey.self] }
        set { self[AnalyticsEnvironmentKey.self] = newValue }
    }
}
