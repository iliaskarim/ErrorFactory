import XCTest
@testable import ErrorFactory

final class ErrorFactoryTests: XCTestCase {
    private var function: String?
    private var line: Int?

    private func throwError() throws {
        function = #function
        line = #line + 1
        throw NSError.error(info: ["foo": "bar", NSLocalizedFailureErrorKey: "failure reason"])

    }

    private func testFactoryMethod() {
        XCTAssertThrowsError(try throwError()) { error in
            let error = error as NSError

            XCTAssertEqual(NSError.defaultCode, error.code)
            XCTAssertEqual(NSError.defaultDescription, error.localizedDescription)
            XCTAssertEqual(#file, error.userInfo[NSError.UserInfoKey.file.rawValue] as? String)
            XCTAssertEqual(function, error.userInfo[NSError.UserInfoKey.function.rawValue] as? String)
            XCTAssertEqual(line, error.userInfo[NSError.UserInfoKey.line.rawValue] as? Int)
            XCTAssertEqual("bar", error.userInfo["foo"] as? String)
        }
    }
}
