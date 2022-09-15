import SwiftUI

public struct AnalyticsAction: Sendable {
    fileprivate let values: AnalyticsValues

    public func callAsFunction(interaction: Analytics.Interaction) {
        Analytics.log(interaction, values: values)
    }

    public func callAsFunction(view: Analytics.View) {
        Analytics.log(view, values: values)
    }
}

public extension EnvironmentValues {
    var analytics: AnalyticsAction {
        .init(values: analyticsValues)
    }
}
