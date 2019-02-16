import Foundation

/**
 Min Max Normalization.

 Formula: x' = (x' - min) / (x' - max)
 Normalized values: 0 <= x' <= 1

 - Parameter array: The floating point array to be normalized.
 - Returns: The normalized array.
 */
public func minMax<T: FloatingPoint>(_ array : [T]) -> [T] {
    guard let (min, max) = minimumMaximum(array) else { return array }
    return array.map{ ($0 - min) / (max - min) }
}

/**
 Max Normalization.

 Formula: x' = x' / max
 Normalized values: 0 <= x' <= 1

 - Parameter array: The floating point array to be normalized.
 - Returns: The normalized array.
 */
public func max<T: FloatingPoint>(_ array : [T]) -> [T] {
    guard let (_, max) = minimumMaximum(array) else { return array }
    return array.map{ $0 / max }
}
