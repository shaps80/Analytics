import Foundation

internal extension EventModifier {
    func param<V>(_ keyPath: WritableKeyPath<ParameterValues, V>, _ value: V) -> ModifiedEvent<Self, ParameterKeyWritingModifier<V>> {
        return modifier(ParameterKeyWritingModifier(keyPath, value))
    }
}

private extension EventModifier {
    func modifier<M>(_ modifier: M) -> ModifiedEvent<Self, M> {
        return ModifiedEvent(event: self, modifier: modifier)
    }
}

internal protocol EventModifier {
    func apply(to context: EventContext)
}

public struct ModifiedEvent<Event, Modifier> {
    var event: Event
    var modifier: Modifier

    internal init(event: Event, modifier: Modifier) {
        self.event = event
        self.modifier = modifier
    }
}

extension ModifiedEvent: EventModifier where Modifier: EventModifier {
    internal func apply(to context: EventContext) {
        modifier.apply(to: context)

        if let event = event as? EventModifier {
            event.apply(to: context)
        }
    }
}
