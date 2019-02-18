import Foundation

public protocol Normalization {
    associatedtype BFPType
    mutating func normalize(_ vector: [BFPType]) -> [BFPType]
    func normalize(_ value: BFPType) -> BFPType
    func deNormalize(_ value: BFPType) -> BFPType
}

public struct MinMaxNormalization<T: BinaryFloatingPoint> : Normalization {
    public typealias BFPType = T

    var min: T?
    var max: T?

    public mutating func normalize(_ vector: [T]) -> [T] {
        guard let (min, max) = minMax(vector) else { return vector }
        self.min = min
        self.max = max

        return vector.map{ ($0 - min) / (max - min) }
    }

    public func normalize(_ value: BFPType) -> BFPType {
        guard let min = self.min, let max = self.max else { return value }
        return (value - min) / (max - min)
    }

    public func deNormalize(_ value: BFPType) -> BFPType {
        guard let min = self.min, let max = self.max else { return value }
        return (value * (max - min)) + min
    }
}


/**
 Min Max Vector Normalization.

 Formula: x' = (x' - min) / (x' - max)
 Normalized values: 0 <= x' <= 1

 - Parameter vector: The floating point one dimension array to be normalized.
 - Returns: The normalized one dimension array.
 */
public func minMaxNormalized<T: BinaryFloatingPoint>(_ vector : [T]) -> [T] {
    guard let (min, max) = minMax(vector) else { return vector }
    return minMaxNormalized(vector, min: min, max: max)
}

/**
 Min Max Vector Normalization.

 Formula: x' = (x' - min) / (x' - max)
 Normalized values: 0 <= x' <= 1

 - Parameter vector: The floating point one dimension array to be normalized.
 - Parameter min: The minimum value of the input vector
 - Parameter max: The maximum value of the input vector
 - Returns: The normalized one dimension array.
 */
public func minMaxNormalized<T: BinaryFloatingPoint>(_ vector : [T], min: T, max: T) -> [T] {
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
    guard let (_, max) = minMax(vector) else { return vector }
    return maxNormalized(vector, max: max)
}

/**
 Max Vector Normalization.

 Formula: x' = x' / max
 Normalized values: 0 <= x' <= 1

 - Parameter vector: The floating point one dimension array to be normalized.
 - Parameter max: The maximum value of the input vector
  - Returns: The normalized one dimension array.
 */
public func maxNormalized<T: BinaryFloatingPoint>(_ vector : [T], max: T) -> [T] {
    return vector.map{ $0 / max }
}

/**
 Mean Vector Normalization.

 Formula: x' = (x' - mean) / (max - min)
 Normalized values: -0.5 <= x' <= 0.5

 - Parameter vector: The floating point one dimension array to be normalized.
 - Returns: The normalized one dimension array.
 */
public func meanNormalized<T: BinaryFloatingPoint>(_ vector : [T]) -> [T] {
    guard let (min, max) = minMax(vector) else { return vector }
    let meanAverage = mean(vector)
    return meanNormalized(vector, min: min, max: max, mean: meanAverage)
}

/**
 Mean Vector Normalization.

 Formula: x' = (x' - mean) / (max - min)
 Normalized values: -0.5 <= x' <= 0.5

 - Parameter vector: The floating point one dimension array to be normalized.
 - Parameter min: The minimum value of the input vector
 - Parameter max: The maximum value of the input vector
 - Parameter mean: The mean value of the input vector
 - Returns: The normalized one dimension array.
 */
public func meanNormalized<T: BinaryFloatingPoint>(_ vector : [T], min: T, max: T, mean: T) -> [T] {
    return vector.map{ ($0 - mean) / (max - min) }
}

/**
 L1 Vector Normalization.

 Formula: x' = x' / ABS(SUM(x))
 Normalized values: 0 <= x' <= 1

 - Parameter vector: The floating point one dimension array to be normalized.
 - Returns: The normalized one dimension array.
 */
public func L1Normalized<T: BinaryFloatingPoint>(_ vector : [T]) -> [T] {
    let absoluteSum = absSum(vector)
    return L1Normalized(vector, absSum: absoluteSum)
}

/**
 L1 Vector Normalization.

 Formula: x' = x' / ABS(SUM(x))
 Normalized values: 0 <= x' <= 1

 - Parameter vector: The floating point one dimension array to be normalized.
 - Parameter absSum: The absolute sum value of the input vector
 - Returns: The normalized one dimension array.
 */
public func L1Normalized<T: BinaryFloatingPoint>(_ vector : [T], absSum: T) -> [T] {
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
    let sqrootSumSquared = sqrtSumSquared(vector)
    return L2Normalized(vector, sqrtSumSquared: sqrootSumSquared)
}

/**
 L2 Vector Normalization.

 Formula: x' = x' / SQRT(SUM(x^2))
 Normalized values: 0 <= x' <= 1

 - Parameter vector: The floating point one dimension array to be normalized.
 - Parameter sqrtSumSquared: The squared root sum of square value of the input vector
 - Returns: The normalized one dimension array.
 */
public func L2Normalized<T: BinaryFloatingPoint>(_ vector : [T], sqrtSumSquared: T) -> [T] {
    return vector.map{ $0 / sqrtSumSquared }
}

/**
 ZScore Vector Normalization.

 Formula: x' = (x' - MEAN(X)) / STD(X)

 - Parameter vector: The floating point one dimension array to be normalized.
 - Returns: The normalized one dimension array.
 */
public func ZScoreNormalized<T: BinaryFloatingPoint>(_ vector : [T]) -> [T] {
    let meanAverage = mean(vector)
    let standardDeviation = std(vector)
    return ZScoreNormalized(vector, mean: meanAverage, std: standardDeviation)
}

/**
 ZScore Vector Normalization.

 Formula: x' = (x' - MEAN(X)) / STD(X)

 - Parameter vector: The floating point one dimension array to be normalized.
 - Parameter mean: The mean value of the input vector
 - Parameter std: The standard deviation value of the input vector
 - Returns: The normalized one dimension array.
 */
public func ZScoreNormalized<T: BinaryFloatingPoint>(_ vector : [T], mean: T, std: T) -> [T] {
    return vector.map{ $0 - mean / std }
}
