import Foundation

/**
 Get Mean - Mean average - of a Vector

 - Parameter vector: The floating point one dimension array.
 - Returns: The mean value.
 */
public func mean<T: BinaryFloatingPoint>(_ vector : [T]) -> T {
    return vector.reduce(0, +) / T(vector.count)
}

/**
 Find Min and Max value of a Vector.

 - Parameter array: The one dimension array.
 - Returns: The tuple of Min and Max value.
 */
public func minMax<T: Comparable>(_ vector: [T]) -> (minimum: T, maximum: T)? {
    guard var minimum = vector.first else { return nil }
    var maximum = minimum

    // if 'vector' has an odd number of items, let 'minimum' or 'maximum' deal with the leftover
    let start = vector.count % 2 // 1 if odd, skipping the first element
    for i in stride(from: start, to: vector.count, by: 2) {
        let (first, second) = (vector[i], vector[i+1])

        if first > second {
            if first > maximum {
                maximum = first
            }
            if second < minimum {
                minimum = second
            }
        } else {
            if second > maximum {
                maximum = second
            }
            if first < minimum {
                minimum = first
            }
        }
    }

    return (minimum, maximum)
}

/**
 Get AbsSum - Absolute Sum - of a Vector

 - Parameter vector: The floating point one dimension array.
 - Returns: The absolute sum value.
 */
public func absSum<T: BinaryFloatingPoint>(_ vector : [T]) -> T {
    return abs(vector.reduce(0, +))
}

/**
 Get SqrtSumSquared - Squared Root Sum Of Square - of a Vector

 - Parameter vector: The floating point one dimension array.
 - Returns: The squared root sum of square value.
 */
public func sqrtSumSquared<T: BinaryFloatingPoint>(_ vector : [T]) -> T {
    return sqrt(vector.reduce(0, { $0 + ($1 * $1) }))
}

/**
 Get STD - Standard Deviation - of a Vector

 - Parameter vector: The floating point one dimension array.
 - Returns: The standard deviation value.
 */
public func std<T: BinaryFloatingPoint>(_ vector : [T]) -> T {
    let length = T(vector.count)
    let avg = vector.reduce(0, +) / length
    let sumOfSquaredAvgDiff = vector.map { pow($0 - avg, 2.0)}.reduce(0, +)
    return sqrt(sumOfSquaredAvgDiff / (length - 1))
}

func sqrt<T : BinaryFloatingPoint>(_ x: T) -> T {
    return T(sqrt(Double(x)))
}

func pow<T : BinaryFloatingPoint>(_ x: T, _ y: T) -> T {
    return T(pow(Double(x), Double(y)))
}