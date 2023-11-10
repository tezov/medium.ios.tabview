public extension Optional {
    var isNil: Bool { self == nil }

    var isNotNil: Bool { self != nil }

    var isInitialized: Bool {
        if case .none = self { return false }
        else { return true }
    }
}
