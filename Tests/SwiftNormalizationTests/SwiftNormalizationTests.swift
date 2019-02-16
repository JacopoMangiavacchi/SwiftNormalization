import XCTest
@testable import SwiftNormalization

final class SwiftNormalizationTests: XCTestCase {
    func testMinMaxFloat() {
        let array: [Float] = [1,2,3,4,5]
        let expectedNormalizedArray: [Float] = [0.0, 0.25, 0.5, 0.75, 1.0]
        let normalizedArray = minMax(array)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testMinMaxDouble() {
        let array: [Double] = [1,2,3,4,5]
        let expectedNormalizedArray: [Double] = [0.0, 0.25, 0.5, 0.75, 1.0]
        let normalizedArray = minMax(array)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testMaxFloat() {
        let array: [Float] = [1,2,3,4,5]
        let expectedNormalizedArray: [Float] = [0.2, 0.4, 0.6, 0.8, 1.0]
        let normalizedArray = max(array)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testMaxDouble() {
        let array: [Double] = [1,2,3,4,5]
        let expectedNormalizedArray: [Double] = [0.2, 0.4, 0.6, 0.8, 1.0]
        let normalizedArray = max(array)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    static var allTests = [
        ("testMinMax", testMinMaxFloat),
        ("testMinMax", testMinMaxDouble),
        ("testMax", testMaxFloat),
        ("testMax", testMaxDouble),
    ]
}
