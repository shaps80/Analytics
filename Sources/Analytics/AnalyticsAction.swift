import SwiftUI

/// An action that logs an analytics event
///
/// When the ``EnvironmentValues/analytics`` environment value contains an instance
/// of this structure, your ``SwiftUI/View`` can log analytics events.
///
///     struct ContactDetailView: View {
///         @Environment(\.analytics) private var log
///         var body: some View {
///             List {
///                 Button("Submit") {
///                     log(interaction: .submit)
///                 }
///             }
///             .onAppear {
///                 log(view: .contactDetail)
///             }
///         }
///     }
///
public struct AnalyticsAction: Sendable {
    fileprivate let values: AnalyticsValues

    /// Logs the specified `view` event
    /// - Parameter view: The view event to log
    public func callAsFunction(view: Analytics.View) {
        Analytics.log(view: view, values: values)
    }

    /// Logs the specified `interaction` event
    /// - Parameter interaction: The interaction event to log
    public func callAsFunction(interaction: Analytics.Interaction) {
        Analytics.log(interaction: interaction, values: values)
    }
}

public extension EnvironmentValues {
    /// Returns the current analytics action for logging events
    ///
    ///     struct ContactDetailView: View {
    ///         @Environment(\.analytics) private var log
    ///         var body: some View {
    ///             List {
    ///                 Button("Submit") {
    ///                     log(interaction: .submit)
    ///                 }
    ///             }
    ///             .onAppear {
    ///                 log(view: .contactDetail)
    ///             }
    ///         }
    ///     }
    ///
    var analytics: AnalyticsAction {
        .init(values: analyticsValues)
    }
}
