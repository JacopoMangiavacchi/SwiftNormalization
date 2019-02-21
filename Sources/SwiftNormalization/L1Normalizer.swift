/**
 L1 Vector Normalizer.

 Formula: x' = x' / ABS(SUM(x))
 Normalized values: 0 <= x' <= 1
*/
public struct L1Normalizer<T: BinaryFloatingPoint> : Normalizer {
    public typealias VectorType = T

    var absoluteSum: T?

    /**
    Normalized vector method.

    Normalize a floating point vector saving the absoluteSum value of the vector.
    These internal state information are needed to later normalize and de-normalize sigle values

    - Parameter vector: The floating point one dimension array to be normalized.
    - Returns: The normalized one dimension array.
    */
    public mutating func normalized(_ vector: [T]) -> [T] {
        let absoluteSum = absSum(vector)
        self.absoluteSum = absoluteSum

        return vector.map{ $0 / absoluteSum }
    }

    /**
    Normalize value method.

    Normalize a single floating point value using the absoluteSum value
    calculated on the normilize vector method.

    - Parameter value: The floating point value to be normalized.
    - Returns: The normalized value.
    */
    public func normalize(_ value: T) -> T {
        guard let absoluteSum = self.absoluteSum else { return value }
        return value / absoluteSum
    }

    /**
    Denormalize value method.

    De-normalize a single floating point value using the min and absoluteSum values
    calculated on the normilize vector method.

    - Parameter value: The floating point value to be de-normalized.
    - Returns: The de-normalized value.
    */
    public func denormalize(_ value: T) -> T {
        guard let absoluteSum = self.absoluteSum else { return value }
        return value * absoluteSum
    }
}
