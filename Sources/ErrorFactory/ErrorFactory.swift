import Foundation

public extension NSError {
    /// Error user info dictionary keys
    enum UserInfoKey: String {
        case callstack
        case file
        case function
        case line
    }

    /// Default error code
    static let defaultCode = -10001

    /// Default error message
    static let defaultDescription = "An undefined error occured."

    /// Creates an error that includes the call site's file name, function name and line number, as well as a symbolic
    /// representation of the current thread's call stack and any provided client data.
    /// - Parameters:
    ///   - code: integer to identify the error
    ///   - description: sentence explaining the error
    ///   - info: optional client dictionary
    ///   - file: file name (defaulted)
    ///   - function: function name (defaulted)
    ///   - line: line number (defaulted)
    /// - Returns: Error object
    static func error(_ code: Int = defaultCode, description: String = defaultDescription, info: [String: Any]? = nil, file: String = #file, function: String = #function, line: Int = #line) -> NSError {
        let defaultInfo: [String: Any] = [
            NSLocalizedDescriptionKey: description,
            UserInfoKey.callstack.rawValue: Thread.callStackSymbols,
            UserInfoKey.file.rawValue: file,
            UserInfoKey.function.rawValue: function,
            UserInfoKey.line.rawValue: line,
        ]
        let userInfo: [String: Any] = (info ?? [:]).reduce(into: defaultInfo) { (result, keyValuePair) in
            let (key, value) = keyValuePair
            result[key] = value
        }
        return NSError(domain: Bundle.main.bundleIdentifier!, code: code, userInfo: userInfo)
    }
}
