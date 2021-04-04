import Foundation

public protocol ParameterKey {
    associatedtype Value
    static var key: String { get }
    static var defaultValue: Value { get }
}
