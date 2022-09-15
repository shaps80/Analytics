import SwiftUI

public extension View {
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
