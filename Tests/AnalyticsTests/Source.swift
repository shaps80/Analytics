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
