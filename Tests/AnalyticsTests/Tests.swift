import XCTest
import SwiftUI

@testable import Analytics

final class Tests: XCTestCase {
    private let observer = MockAnalyticsObserver()

    override func setUp() {
        Analytics.register(observer)
    }

    func test() {
        Analytics.log(view: .contactList, values: .init())
        XCTAssertEqual(observer.eventName, Analytics.View.contactList.rawValue)
        XCTAssertEqual(observer.params, [:])

        var values = AnalyticsValues()
        values.source = .contactList

        Analytics.log(interaction: .submit, values: values)
        XCTAssertEqual(observer.eventName, Analytics.Interaction.submit.rawValue)
        XCTAssertEqual(observer.params, ["source": Source.contactList.rawValue])
    }
}

final class MockAnalyticsObserver: AnalyticsObserver, @unchecked Sendable {
    var eventName: String = ""
    var params: [String: String] = [:]

    func log(view: Analytics.View, values: AnalyticsValues) {
        eventName = view.rawValue
        params = values.params.mapValues { "\($0)" }
        print("\(view) | \(values.description)")
    }

    func log(interaction: Analytics.Interaction, values: AnalyticsValues) {
        eventName = interaction.rawValue
        params = values.params.mapValues { "\($0)" }
        print("\(interaction) | \(values.description)")
    }
}

extension Analytics.View {
    static var contactList: Self { .init(rawValue: "contact-list") }
}

extension Analytics.Interaction {
    static var submit: Self { .init(rawValue: "submit") }
}

enum Source: String, CustomStringConvertible {
    case contactList = "contact-list"
    var description: String { rawValue }
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
