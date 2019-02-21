import XCTest
@testable import SwiftNormalization

final class SwiftNormalizationTests: XCTestCase {
    let inputVectorFloat: [Float] = [1,2,3,4,5]
    let inputVectorDouble: [Double] = [1,2,3,4,5]

    // Common Test method
    func test<N: Normalizer, T: BinaryFloatingPoint>(normalizer: N, vector: [T], expected: [T]) where N.VectorType == T {
        var mutableNormalizer = normalizer

        XCTAssertEqual(mutableNormalizer.normalized(vector), expected)

        for i in 0..<vector.count {
            XCTAssertEqual(mutableNormalizer.normalize(vector[i]), expected[i])
            XCTAssertEqual(mutableNormalizer.denormalize(expected[i]), vector[i])
        }

        let middle = (vector[1] + vector[2]) / T(2.0)
        let middleNormalized = mutableNormalizer.normalize(middle)
        XCTAssertEqual(mutableNormalizer.denormalize(middleNormalized), middle)
    }

    // Test MinMax Normalizer
    func testMinMax() {
        let expectedVectorFloat: [Float] = [0.0, 0.25, 0.5, 0.75, 1.0]
        let expectedVectorDouble: [Double] = [0.0, 0.25, 0.5, 0.75, 1.0]

        test(normalizer: MinMaxNormalizer<Float>(), vector: inputVectorFloat, expected: expectedVectorFloat)
        test(normalizer: MinMaxNormalizer<Double>(), vector: inputVectorDouble, expected: expectedVectorDouble)
    }

    // Test Max Normalizer
    func testMax() {
        let expectedVectorFloat: [Float] = [0.2, 0.4, 0.6, 0.8, 1.0]
        let expectedVectorDouble: [Double] = [0.2, 0.4, 0.6, 0.8, 1.0]

        test(normalizer: MaxNormalizer<Float>(), vector: inputVectorFloat, expected: expectedVectorFloat)
        test(normalizer: MaxNormalizer<Double>(), vector: inputVectorDouble, expected: expectedVectorDouble)
    }

    // Test Mean Normalizer
    func testMean() {
        let expectedVectorFloat: [Float] = [-0.5, -0.25, 0.0, 0.25, 0.5]
        let expectedVectorDouble: [Double] = [-0.5, -0.25, 0.0, 0.25, 0.5]

        test(normalizer: MeanNormalizer<Float>(), vector: inputVectorFloat, expected: expectedVectorFloat)
        test(normalizer: MeanNormalizer<Double>(), vector: inputVectorDouble, expected: expectedVectorDouble)
    }









    func testL1Float() {
        let expectedNormalizedArray: [Float] = [0.06666667, 0.13333334, 0.2, 0.26666668, 0.33333334]
        let normalizedArray = L1Normalized(inputVectorFloat)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testL1Double() {
        let expectedNormalizedArray: [Double] = [0.06666666666666667, 0.13333333333333333, 0.2, 0.26666666666666666, 0.3333333333333333]
        let normalizedArray = L1Normalized(inputVectorDouble)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testL2Float() {
        let expectedNormalizedArray: [Float] = [0.13483998, 0.26967996, 0.40451992, 0.5393599, 0.6741999]
        let normalizedArray = L2Normalized(inputVectorFloat)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testL2Double() {
        let expectedNormalizedArray: [Double] = [0.13483997249264842, 0.26967994498529685, 0.40451991747794525, 0.5393598899705937, 0.674199862463242]
        let normalizedArray = L2Normalized(inputVectorDouble)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testZScoreFloat() {
        let expectedNormalizedArray: [Float] = [-0.8973665, 0.102633476, 1.1026335, 2.1026335, 3.1026335]
        let normalizedArray = ZScoreNormalized(inputVectorFloat)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    func testZScoreDouble() {
        let expectedNormalizedArray: [Double] = [-0.8973665961010275, 0.10263340389897246, 1.1026334038989725, 2.1026334038989725, 3.1026334038989725]
        let normalizedArray = ZScoreNormalized(inputVectorDouble)

        XCTAssertEqual(normalizedArray, expectedNormalizedArray)
    }

    static var allTests = [
        ("Test MinMax", testMinMax),
        ("Test Max", testMax),
        ("Test Mean", testMean),

        ("Test L1 Float", testL1Float),
        ("Test L1 Double", testL1Double),
        ("Test L2 Float", testL2Float),
        ("Test L2 Double", testL2Double),
        ("Test ZScore Float", testZScoreFloat),
        ("Test ZScore Double", testZScoreDouble),
    ]
}
