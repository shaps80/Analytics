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
        let action = AnalyticsAction(values: values)

        action(.view)
        XCTAssertEqual(observer.eventName, ViewEvent.view.name)
        XCTAssertEqual(observer.params, [SourceAnalyticsKey.key: Source.contactList.rawValue])
    }
    
    func testLogEventActionWithReplacedValues() {
        var values = AnalyticsValues()
        values[keyPath: \.source] = .contactList
        var action = AnalyticsAction(values: values)

        XCTAssertFalse(values.params.isEmpty)
        action(.view, replacing: .init())
        XCTAssertEqual(observer.eventName, ViewEvent.view.name)
        XCTAssertEqual(observer.params, [:])
        
        action(.view)
        XCTAssertEqual(observer.params, [SourceAnalyticsKey.key: Source.contactList.rawValue])
    }

    func testLogEventActionWithAppendedValues() {
        let action = AnalyticsAction(values: .init())
        var values = AnalyticsValues()
        values[keyPath: \.source] = .contactList
        action(.view, appending: values)
        XCTAssertEqual(observer.eventName, ViewEvent.view.name)
        XCTAssertEqual(observer.params, [SourceAnalyticsKey.key: Source.contactList.rawValue])
    }
    
    func testAppendedValuesClearForSubsequentLogs() {
        let action = AnalyticsAction(values: .init())
        var newValues = AnalyticsValues()
        
        newValues[keyPath: \.source] = .contactList
        newValues[keyPath: \.component] = .button
        action(.view, appending: newValues)
        
        XCTAssertEqual(observer.eventName, ViewEvent.view.name)
        XCTAssertEqual(observer.params, [ComponentAnalyticsKey.key: Component.button.rawValue, SourceAnalyticsKey.key: Source.contactList.rawValue])
        
        action(.view)
        XCTAssertEqual(observer.eventName, ViewEvent.view.name)
        XCTAssertEqual(observer.params, [:])
    }

    func testLogEventUnique() {
        var values = AnalyticsValues()
        values[keyPath: \.source] = .contactList

        let action = AnalyticsAction(values: values)
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
