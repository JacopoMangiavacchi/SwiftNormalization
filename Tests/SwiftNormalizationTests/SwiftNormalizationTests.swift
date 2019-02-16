import XCTest
@testable import SwiftNormalization

final class SwiftNormalizationTests: XCTestCase {
    func testMinMaxFloat() {
        let array: [Float] = [1,2,3,4,5]
        let expectedNormalizedArray: [Float] = [0.0, 0.25, 0.5, 0.75, 1.0]
        let normalizedArray = minMaxNormalized(array)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testMinMaxDouble() {
        let array: [Double] = [1,2,3,4,5]
        let expectedNormalizedArray: [Double] = [0.0, 0.25, 0.5, 0.75, 1.0]
        let normalizedArray = minMaxNormalized(array)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testMaxFloat() {
        let array: [Float] = [1,2,3,4,5]
        let expectedNormalizedArray: [Float] = [0.2, 0.4, 0.6, 0.8, 1.0]
        let normalizedArray = maxNormalized(array)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testMaxDouble() {
        let array: [Double] = [1,2,3,4,5]
        let expectedNormalizedArray: [Double] = [0.2, 0.4, 0.6, 0.8, 1.0]
        let normalizedArray = maxNormalized(array)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testL1Float() {
        let array: [Float] = [1,2,3,4,5]
        let expectedNormalizedArray: [Float] = [0.06666667, 0.13333334, 0.2, 0.26666668, 0.33333334]
        let normalizedArray = L1Normalized(array)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testL1Double() {
        let array: [Double] = [1,2,3,4,5]
        let expectedNormalizedArray: [Double] = [0.06666666666666667, 0.13333333333333333, 0.2, 0.26666666666666666, 0.3333333333333333]
        let normalizedArray = L1Normalized(array)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    static var allTests = [
        ("Test MinMax Float", testMinMaxFloat),
        ("Test MinMax Double", testMinMaxDouble),
        ("Test Max Float", testMaxFloat),
        ("Test Max Double", testMaxDouble),
        ("Test L1 Float", testL1Float),
        ("Test L1 Double", testL1Double),
    ]
}
