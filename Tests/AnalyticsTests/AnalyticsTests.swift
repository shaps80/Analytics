import XCTest
@testable import Analytics

final class AnalyticsTests: XCTestCase {
    func testWithoutParameters() {
        let event = Event(.termsAccepted)
        let context = EventContext(event)
        XCTAssertEqual(context.name, .termsAccepted)
        XCTAssert(context.parameters.isEmpty)
    }

    func testWithParameters() {
        let event = Event(.pair)
            .param(\.pairingState, .paired)
            .param(\.user, "1234")

        let context = EventContext(event)
        XCTAssertEqual(context.name, .pair)
        XCTAssert(context.values[PairingStateParameterKey.self] == .paired)
        XCTAssert(context.values[SignInStateParameterKey.self] == "1234")
    }
}

