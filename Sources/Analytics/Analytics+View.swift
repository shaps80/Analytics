import SwiftUI

public extension View {
    /// Sets the analytics value of the specified key path to the given value
    ///
    /// Use this modifier to set one of the writable properties of the
    /// ``AnalyticsKey`` structure, including custom values that you
    /// create.
    ///
    ///     ContactDetailView()
    ///         .analytics(\.source, .contactList)
    ///
    /// - Parameters:
    ///   - keyPath: A key path thatindicates the property of the `AnalyticsKey`
    ///   structure to update
    ///   - value: The new value to set for the specified key path
    /// - Returns: A view that has the given value set in its analytics values
    func analytics<V>(_ keyPath: WritableKeyPath<AnalyticsValues, V>, _ value: V) -> some View {
        modifier(AnalyticsViewModifier(keyPath, value))
    }
}

private struct AnalyticsViewModifier<V>: ViewModifier {
    @Environment(\.analyticsValues) private var values

    let keyPath: WritableKeyPath<AnalyticsValues, V>
    let value: V

    init(_ keyPath: WritableKeyPath<AnalyticsValues, V>, _ value: V) {
        self.keyPath = keyPath
        self.value = value
    }

    func body(content: Content) -> some View {
        content.environment(\.analyticsValues, resolvedValues)
    }

    private var resolvedValues: AnalyticsValues {
        var params = values
        params[keyPath: keyPath] = value
        return params
    }
}
