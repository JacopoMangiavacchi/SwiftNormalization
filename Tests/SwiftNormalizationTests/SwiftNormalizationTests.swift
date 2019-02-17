import XCTest
@testable import SwiftNormalization

final class SwiftNormalizationTests: XCTestCase {
    let floatArray: [Float] = [1,2,3,4,5]
    let doubleArray: [Double] = [1,2,3,4,5]

    func testMinMaxFloat() {
        let expectedNormalizedArray: [Float] = [0.0, 0.25, 0.5, 0.75, 1.0]
        let normalizedArray = minMaxNormalized(floatArray)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testMinMaxDouble() {
        let expectedNormalizedArray: [Double] = [0.0, 0.25, 0.5, 0.75, 1.0]
        let normalizedArray = minMaxNormalized(doubleArray)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testMaxFloat() {
        let expectedNormalizedArray: [Float] = [0.2, 0.4, 0.6, 0.8, 1.0]
        let normalizedArray = maxNormalized(floatArray)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testMaxDouble() {
        let expectedNormalizedArray: [Double] = [0.2, 0.4, 0.6, 0.8, 1.0]
        let normalizedArray = maxNormalized(doubleArray)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testMeanFloat() {
        let expectedNormalizedArray: [Float] = [-0.5, -0.25, 0.0, 0.25, 0.5]
        let normalizedArray = meanNormalized(floatArray)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testMeanDouble() {
        let expectedNormalizedArray: [Double] = [-0.5, -0.25, 0.0, 0.25, 0.5]
        let normalizedArray = meanNormalized(doubleArray)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testL1Float() {
        let expectedNormalizedArray: [Float] = [0.06666667, 0.13333334, 0.2, 0.26666668, 0.33333334]
        let normalizedArray = L1Normalized(floatArray)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testL1Double() {
        let expectedNormalizedArray: [Double] = [0.06666666666666667, 0.13333333333333333, 0.2, 0.26666666666666666, 0.3333333333333333]
        let normalizedArray = L1Normalized(doubleArray)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testL2Float() {
        let expectedNormalizedArray: [Float] = [0.13483998, 0.26967996, 0.40451992, 0.5393599, 0.6741999]
        let normalizedArray = L2Normalized(floatArray)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testL2Double() {
        let expectedNormalizedArray: [Double] = [0.13483997249264842, 0.26967994498529685, 0.40451991747794525, 0.5393598899705937, 0.674199862463242]
        let normalizedArray = L2Normalized(doubleArray)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testZScoreFloat() {
        let expectedNormalizedArray: [Float] = [-0.8973665, 0.102633476, 1.1026335, 2.1026335, 3.1026335]
        let normalizedArray = ZScoreNormalized(floatArray)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testZScoreDouble() {
        let expectedNormalizedArray: [Double] = [-0.8973665961010275, 0.10263340389897246, 1.1026334038989725, 2.1026334038989725, 3.1026334038989725]
        let normalizedArray = ZScoreNormalized(doubleArray)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    static var allTests = [
        ("Test MinMax Float", testMinMaxFloat),
        ("Test MinMax Double", testMinMaxDouble),
        ("Test Max Float", testMaxFloat),
        ("Test Max Double", testMaxDouble),
        ("Test Mean Float", testMeanFloat),
        ("Test Mean Double", testMeanDouble),
        ("Test L1 Float", testL1Float),
        ("Test L1 Double", testL1Double),
        ("Test L2 Float", testL2Float),
        ("Test L2 Double", testL2Double),
        ("Test ZScore Float", testZScoreFloat),
        ("Test ZScore Double", testZScoreDouble),
    ]
}
