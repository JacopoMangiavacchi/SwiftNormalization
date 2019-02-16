import Foundation

/**
 Find Min and Max value of a Vector.

 - Parameter array: The one dimension array.
 - Returns: The tuple of Min and Max value.
 */
public func minimumMaximum<T: Comparable>(_ vector: [T]) -> (minimum: T, maximum: T)? {
    guard var minimum = vector.first else { return nil }
    var maximum = minimum

    // if 'vector' has an odd number of items, let 'minimum' or 'maximum' deal with the leftover
    let start = vector.count % 2 // 1 if odd, skipping the first element
    for i in stride(from: start, to: vector.count, by: 2) {
        let pair = (vector[i], vector[i+1])

        if pair.0 > pair.1 {
            if pair.0 > maximum {
                maximum = pair.0
            }
            if pair.1 < minimum {
                minimum = pair.1
            }
        } else {
            if pair.1 > maximum {
                maximum = pair.1
            }
            if pair.0 < minimum {
                minimum = pair.0
            }
        }
    }

    return (minimum, maximum)
}

/**
 Get STD - Standard Deviation - of a Vector

 - Parameter vector: The floating point one dimension array.
 - Returns: The standard deviation value.
 */
public func std<T: BinaryFloatingPoint>(_ vector : [T]) -> T
{
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