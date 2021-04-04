import Foundation

public enum PairingState: String {
    case unpaired
    case pairing
    case paired
}

public enum PairingStateParameterKey: ParameterKey {
    public static var key: String { "state" }
    public static var defaultValue: PairingState { .unpaired }
}

public extension ParameterValues {
    var pairingState: PairingState {
        set { self[PairingStateParameterKey.self] = newValue }
        get { self[PairingStateParameterKey.self] }
    }
}
