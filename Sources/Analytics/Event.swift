import Foundation

public struct Event {
    var name: Name

    public init(_ name: Name) {
        self.name = name
    }
}

extension Event: EventModifier {
    func push(to context: EventContext) {
        context.name = name
    }
}

extension Event {

    public struct Name: Hashable, Identifiable, RawRepresentable, ExpressibleByStringLiteral {
        public var rawValue: String
        public var id: String { rawValue }

        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public init(stringLiteral value: String) {
            self.rawValue = value
        }
    }

}
