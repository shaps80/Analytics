import XCTest
import SwiftUI

@testable import Analytics

final class Tests: XCTestCase {
    private let observer = MockAnalyticsObserver()

    override func setUp() {
        Analytics.register(observer)
    }

    func test() {
        let expected = Analytics.View(rawValue: "view")

        observer.logView = { actual in
            XCTAssertEqual(expected, actual)
        }

        Analytics.log(expected, values: .init())
    }
}

final class MockAnalyticsObserver: AnalyticsObserver {
    var logView: (Analytics.View) -> Void = { _ in }

    func log(view: Analytics.View, values: AnalyticsValues) {
        logView(view)
    }

    func log(interaction: Analytics.Interaction, values: AnalyticsValues) { }
}

enum Source {
    case taskList
}

private struct SourceAnalyticsKey: AnalyticsKey {
    typealias Value = Source
    static let key: String = "source"
}

extension AnalyticsValues {
    var source: Source? {
        get { self[SourceAnalyticsKey.self] }
        set { self[SourceAnalyticsKey.self] = newValue }
    }
}
