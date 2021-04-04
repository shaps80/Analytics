import Foundation

public struct ParameterKeyWritingModifier<Value>: EventModifier {

    typealias ParameterKeyPath = WritableKeyPath<ParameterValues, Value>

    private let keyPath: ParameterKeyPath
    private let value: Value

    internal init(_ keyPath: ParameterKeyPath, _ value: Value) {
        self.keyPath = keyPath
        self.value = value
    }

    internal func push(to context: EventContext) {
        var values = context.values
        values[keyPath: keyPath] = value
        context.values = values
    }
}
