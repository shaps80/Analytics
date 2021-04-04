import Foundation

public struct ParameterValues {
    var values: [String: Any] = [:]
    init() { }

    public subscript<K: ParameterKey>(key: K.Type) -> K.Value {
        set {
            if case Optional<Any>.none = newValue as Any {
                return
            } else if case Optional<Any>.some(let value) = newValue as Any {
                values[key.key] = value
            } else {
                values[key.key] = newValue
            }
        }
        get {
            guard let value = values[key.key] as? K.Value else {
                return K.defaultValue
            }

            return value
        }
    }
}

public extension ParameterValues {
    static let empty = ParameterValues()
}
