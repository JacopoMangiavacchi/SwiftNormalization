/**
 Max Vector Normalizer.

 Formula: x' = x' / max
 Normalized values: 0 <= x' <= 1
*/
public struct MaxNormalizer<T: BinaryFloatingPoint> : Normalizer {
    public typealias VectorType = T

    var max: T?

    /**
    Normalized vector method.

    Normalize a floating point vector saving the max value of the vector.
    These internal state information are needed to later normalize and de-normalize sigle values

    - Parameter vector: The floating point one dimension array to be normalized.
    - Returns: The normalized one dimension array.
    */
    public mutating func normalized(_ vector: [T]) -> [T] {
        guard let (_, max) = minMax(vector) else { return vector }
        self.max = max

        return vector.map{ $0 / max }
    }

    /**
    Normalize value method.

    Normalize a single floating point value using the max value
    calculated on the normilize vector method.

    - Parameter value: The floating point value to be normalized.
    - Returns: The normalized value.
    */
    public func normalize(_ value: T) -> T {
        guard let max = self.max else { return value }
        return value / max
    }

    /**
    Denormalize value method.

    De-normalize a single floating point value using the min and max values
    calculated on the normilize vector method.

    - Parameter value: The floating point value to be de-normalized.
    - Returns: The de-normalized value.
    */
    public func denormalize(_ value: T) -> T {
        guard let max = self.max else { return value }
        return value * max
    }
}