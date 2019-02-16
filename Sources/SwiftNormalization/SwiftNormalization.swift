import Foundation

/**
 Min Max Vector Normalization.

 Formula: x' = (x' - min) / (x' - max)
 Normalized values: 0 <= x' <= 1

 - Parameter vector: The floating point one dimension array to be normalized.
 - Returns: The normalized one dimension array.
 */
public func minMaxNormalized<T: BinaryFloatingPoint>(_ vector : [T]) -> [T] {
    guard let (min, max) = minimumMaximum(vector) else { return vector }
    return vector.map{ ($0 - min) / (max - min) }
}

/**
 Max Vector Normalization.

 Formula: x' = x' / max
 Normalized values: 0 <= x' <= 1

 - Parameter vector: The floating point one dimension array to be normalized.
 - Returns: The normalized one dimension array.
 */
public func maxNormalized<T: BinaryFloatingPoint>(_ vector : [T]) -> [T] {
    guard let (_, max) = minimumMaximum(vector) else { return vector }
    return vector.map{ $0 / max }
}

/**
 L1 Vector Normalization.

 Formula: x' = x' / ABS(SUM(x))
 Normalized values: 0 <= x' <= 1

 - Parameter vector: The floating point one dimension array to be normalized.
 - Returns: The normalized one dimension array.
 */
public func L1Normalized<T: BinaryFloatingPoint>(_ vector : [T]) -> [T] {
    let absSum = abs(vector.reduce(0, +))
    return vector.map{ $0 / absSum }
}

/**
 L2 Vector Normalization.

 Formula: x' = x' / SQRT(SUM(x^2))
 Normalized values: 0 <= x' <= 1

 - Parameter vector: The floating point one dimension array to be normalized.
 - Returns: The normalized one dimension array.
 */
public func L2Normalized<T: BinaryFloatingPoint>(_ vector : [T]) -> [T] {
    let sqrtSumSquared = sqrt(vector.reduce(0, { $0 + ($1 * $1) }))
    return vector.map{ $0 / sqrtSumSquared }
}

/**
 ZScore Vector Normalization.

 Formula: x' = (x' - MEAN(X)) / STD(X)

 - Parameter vector: The floating point one dimension array to be normalized.
 - Returns: The normalized one dimension array.
 */
public func ZScoreNormalized<T: BinaryFloatingPoint>(_ vector : [T]) -> [T] {
    let mean = vector.reduce(0, +) / T(vector.count)
    let standardDeviation = std(vector)
    return vector.map{ $0 - mean / standardDeviation }
}
