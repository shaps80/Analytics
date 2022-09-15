import Foundation

public extension Analytics {
    /// A type to represent an `interaction` event.
    ///
    /// Generally you define your events as a static  instance of this type:
    ///
    ///     extension Analytics.Interaction {
    ///         static var submit: Self { .init(rawValue: "submit") }
    ///     }
    struct Interaction: RawRepresentable, Hashable, Sendable, CustomStringConvertible {
        public var rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public var description: String { rawValue }
    }
}

public extension Analytics {
    /// A type to represent an `view` event.
    ///
    /// Generally you define your events as a static  instance of this type:
    ///
    ///     extension Analytics.View {
    ///         static var contactList: Self { .init(rawValue: "contact-list") }
    ///     }
    struct View: RawRepresentable, Hashable, Sendable, CustomStringConvertible {
        public var rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public var description: String { rawValue }
    }
}
