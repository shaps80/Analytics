import XCTest
import SwiftUI

@testable import Analytics

final class Tests: XCTestCase {
    private let observer = MockAnalyticsObserver()

    override func setUp() {
        Analytics.register(observer)
    }

    func testLogEvent() {
        var values = AnalyticsValues()
        values[keyPath: \.source] = .contactList

        Analytics.log(event: .view, values: values)
        XCTAssertEqual(observer.eventName, ViewEvent.view.name)
        XCTAssertEqual(observer.params, [SourceAnalyticsKey.key: Source.contactList.rawValue])
    }
    
    func testLogEventAction() {
        var values = AnalyticsValues()
        values[keyPath: \.source] = .contactList
        var action = AnalyticsAction(values: values)

        action(.view)
        XCTAssertEqual(observer.eventName, ViewEvent.view.name)
        XCTAssertEqual(observer.params, [SourceAnalyticsKey.key: Source.contactList.rawValue])
    }
    
    func testLogEventReplacingValues() {
        var values = AnalyticsValues()
        values[keyPath: \.source] = .contactList
        var action = AnalyticsAction(values: values)

        action(.view, appending: values)
        action(.view, replacing: nil)
        XCTAssertEqual(observer.eventName, ViewEvent.view.name)
        XCTAssertEqual(observer.params, [:])
    }

    func testLogEventAppendingValues() {
        var action = AnalyticsAction(values: .init())
        var values = AnalyticsValues()
        values[keyPath: \.source] = .contactList
        action(.view, appending: values)
        XCTAssertEqual(observer.eventName, ViewEvent.view.name)
        XCTAssertEqual(observer.params, [SourceAnalyticsKey.key: Source.contactList.rawValue])
    }

    func testLogEventUnique() {
        var values = AnalyticsValues()
        values[keyPath: \.source] = .contactList

        var action = AnalyticsAction(values: values)
        action(.view, appending: values)
        XCTAssertEqual(observer.eventName, ViewEvent.view.name)
        XCTAssertEqual(observer.params, [SourceAnalyticsKey.key: Source.contactList.rawValue])
        XCTAssertEqual(observer.params.count, 1)
    }
}

private struct ViewEvent: AnalyticsEvent {
    var name: String { "view" }
}

extension AnalyticsEvent where Self == ViewEvent {
    static var view: Self { .init() }
}
