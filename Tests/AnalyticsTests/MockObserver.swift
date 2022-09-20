import Analytics

final class MockAnalyticsObserver: AnalyticsObserver, @unchecked Sendable {
    var eventName: String = ""
    var params: [String: String] = [:]

    func log(event: AnalyticsEvent, values: AnalyticsValues) {
        eventName = event.name
        params = values.params.mapValues { "\($0)" }
        print("\(eventName) | \(values.description)")
    }
}
