import Foundation

public enum SignInStateParameterKey: ParameterKey {
    public static var key: String { "user_uuid" }
    public static var defaultValue: String? { nil }
}

public extension ParameterValues {
    var user: String? {
        set { self[SignInStateParameterKey.self] = newValue }
        get { self[SignInStateParameterKey.self] }
    }
}
