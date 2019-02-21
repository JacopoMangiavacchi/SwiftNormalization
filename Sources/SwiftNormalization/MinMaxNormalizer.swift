/**
 Min Max Vector Normalizer.

 Formula: x' = (x' - min) / (x' - max)
 Normalized values: 0 <= x' <= 1
 */
public struct MinMaxNormalizer<T: BinaryFloatingPoint> : Normalizer {
    public typealias VectorType = T

    var min: T?
    var max: T?

    /**
    Normalized vector method.

    Normalize a floating point vector saving min and max values of the vector.
    These internal state information are needed to later normalize and de-normalize sigle values

    - Parameter vector: The floating point one dimension array to be normalized.
    - Returns: The normalized one dimension array.
    */
    public mutating func normalized(_ vector: [T]) -> [T] {
        guard let (min, max) = minMax(vector) else { return vector }
        self.min = min
        self.max = max

        return vector.map{ ($0 - min) / (max - min) }
    }

    /**
    Normalize value method.

    Normalize a single floating point value using the min and max values
    calculated on the normilize vector method.

    - Parameter value: The floating point value to be normalized.
    - Returns: The normalized value.
    */
    public func normalize(_ value: T) -> T {
        guard let min = self.min, let max = self.max else { return value }
        return (value - min) / (max - min)
    }

    /**
    Denormalize value method.

    De-normalize a single floating point value using the min and max values
    calculated on the normilize vector method.

    - Parameter value: The floating point value to be de-normalized.
    - Returns: The de-normalized value.
    */
    public func denormalize(_ value: T) -> T {
        guard let min = self.min, let max = self.max else { return value }
        return (value * (max - min)) + min
    }
}