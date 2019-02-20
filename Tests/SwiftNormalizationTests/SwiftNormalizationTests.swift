import XCTest
@testable import SwiftNormalization

final class SwiftNormalizationTests: XCTestCase {
    let floatVector: [Float] = [1,2,3,4,5]
    let doubleVector: [Double] = [1,2,3,4,5]

    func testFloat<N: Normalization>(normalizer: N, expected: [Float]) where N.BFPType == Float {
        var mutableNormalizer = normalizer

        XCTAssertEqual(mutableNormalizer.normalized(floatVector), expected)

        for i in 0..<floatVector.count {
            XCTAssertEqual(mutableNormalizer.normalize(floatVector[i]), expected[i])
            XCTAssertEqual(mutableNormalizer.denormalize(expected[i]), floatVector[i])
        }

        let middle = floatVector[1] + floatVector[2] / 2.0
        let middleNormalized = mutableNormalizer.normalize(middle)
        XCTAssertEqual(mutableNormalizer.denormalize(middleNormalized), middle)
    }

    func testDouble<N: Normalization>(normalizer: N, expected: [Double]) where N.BFPType == Double {
        var mutableNormalizer = normalizer

        XCTAssertEqual(mutableNormalizer.normalized(doubleVector), expected)

        for i in 0..<doubleVector.count {
            XCTAssertEqual(mutableNormalizer.normalize(doubleVector[i]), expected[i])
            XCTAssertEqual(mutableNormalizer.denormalize(expected[i]), doubleVector[i])
        }

        let middle = doubleVector[1] + doubleVector[2] / 2.0
        let middleNormalized = mutableNormalizer.normalize(middle)
        XCTAssertEqual(mutableNormalizer.denormalize(middleNormalized), middle)
    }

    func testMinMax() {
        let expectedFloat: [Float] = [0.0, 0.25, 0.5, 0.75, 1.0]
        let expectedDouble: [Double] = [0.0, 0.25, 0.5, 0.75, 1.0]

        testFloat(normalizer: MinMaxNormalization<Float>(), expected: expectedFloat)
        testDouble(normalizer: MinMaxNormalization<Double>(), expected: expectedDouble)
    }






    func testMinMaxDouble() {
        let expectedNormalizedArray: [Double] = [0.0, 0.25, 0.5, 0.75, 1.0]
        let normalizedArray = minMaxNormalized(doubleVector)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testMaxFloat() {
        let expectedNormalizedArray: [Float] = [0.2, 0.4, 0.6, 0.8, 1.0]
        let normalizedArray = maxNormalized(floatVector)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testMaxDouble() {
        let expectedNormalizedArray: [Double] = [0.2, 0.4, 0.6, 0.8, 1.0]
        let normalizedArray = maxNormalized(doubleVector)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testMeanFloat() {
        let expectedNormalizedArray: [Float] = [-0.5, -0.25, 0.0, 0.25, 0.5]
        let normalizedArray = meanNormalized(floatVector)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testMeanDouble() {
        let expectedNormalizedArray: [Double] = [-0.5, -0.25, 0.0, 0.25, 0.5]
        let normalizedArray = meanNormalized(doubleVector)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testL1Float() {
        let expectedNormalizedArray: [Float] = [0.06666667, 0.13333334, 0.2, 0.26666668, 0.33333334]
        let normalizedArray = L1Normalized(floatVector)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testL1Double() {
        let expectedNormalizedArray: [Double] = [0.06666666666666667, 0.13333333333333333, 0.2, 0.26666666666666666, 0.3333333333333333]
        let normalizedArray = L1Normalized(doubleVector)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testL2Float() {
        let expectedNormalizedArray: [Float] = [0.13483998, 0.26967996, 0.40451992, 0.5393599, 0.6741999]
        let normalizedArray = L2Normalized(floatVector)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testL2Double() {
        let expectedNormalizedArray: [Double] = [0.13483997249264842, 0.26967994498529685, 0.40451991747794525, 0.5393598899705937, 0.674199862463242]
        let normalizedArray = L2Normalized(doubleVector)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testZScoreFloat() {
        let expectedNormalizedArray: [Float] = [-0.8973665, 0.102633476, 1.1026335, 2.1026335, 3.1026335]
        let normalizedArray = ZScoreNormalized(floatVector)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testZScoreDouble() {
        let expectedNormalizedArray: [Double] = [-0.8973665961010275, 0.10263340389897246, 1.1026334038989725, 2.1026334038989725, 3.1026334038989725]
        let normalizedArray = ZScoreNormalized(doubleVector)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    static var allTests = [
        ("Test MinMax", testMinMax),
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
