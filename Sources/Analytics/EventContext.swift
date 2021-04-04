import Foundation

internal final class EventContext {
    var name: Event.Name = ""
    var values: ParameterValues = .empty

    init<E: EventModifier>(_ event: E) {
        event.apply(to: self)
    }
}

extension EventContext {
    internal var parameters: [String: Any] {
        Dictionary(uniqueKeysWithValues: values.values.map {
            ($0.key, "\($0.value)")
        })
    }
}

extension EventContext: CustomStringConvertible {
    var description: String {
        var description = "\(name)"
        if !values.values.isEmpty {
            description += " | "
            description += values.values
                .compactMapValues { $0 }
                .map { "\($0.key):\($0.value)" }
                .joined(separator: " ")
        }
        return description
    }
}

extension EventContext: CustomDebugStringConvertible {
    var debugDescription: String {
        var description = "Event '\(name)'"
        if !values.values.isEmpty {
            description += "\n"
            description += values.values
                .compactMapValues { $0 }
                .map { "- \($0.key): \($0.value)" }
                .joined(separator: "\n")
        }
        return description
    }
}
