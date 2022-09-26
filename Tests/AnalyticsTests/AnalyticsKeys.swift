import Analytics

enum Source: String, CustomStringConvertible {
    case contactList = "contact-list"
    var description: String { rawValue }
}

struct SourceAnalyticsKey: AnalyticsKey {
    typealias Value = Source
    static let key: String = "source"
}

extension AnalyticsValues {
    var source: Source? {
        get { self[SourceAnalyticsKey.self] }
        set { self[SourceAnalyticsKey.self] = newValue }
    }
}

enum Component: String, CustomStringConvertible {
    case button = "button"
    var description: String { rawValue }
}

struct ComponentAnalyticsKey: AnalyticsKey {
    typealias Value = Component
    static let key: String = "component"
}

extension AnalyticsValues {
    var component: Component? {
        get { self[ComponentAnalyticsKey.self] }
        set { self[ComponentAnalyticsKey.self] = newValue }
    }
}
