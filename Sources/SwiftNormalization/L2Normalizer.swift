/**
 L2 Vector Normalizer.

 Formula: x' = x' / SQRT(SUM(x^2))
 Normalized values: 0 <= x' <= 1
*/
public struct L2Normalizer<T: BinaryFloatingPoint> : Normalizer {
    public typealias VectorType = T

    var sqrootSumSquared: T?

    /**
    Normalized vector method.

    Normalize a floating point vector saving the squared root sum of square value of the vector.
    These internal state information are needed to later normalize and de-normalize sigle values

    - Parameter vector: The floating point one dimension array to be normalized.
    - Returns: The normalized one dimension array.
    */
    public mutating func normalized(_ vector: [T]) -> [T] {
        let sqrootSumSquared = sqrtSumSquared(vector)
        self.sqrootSumSquared = sqrootSumSquared

        return vector.map{ $0 / sqrootSumSquared }
    }

    /**
    Normalize value method.

    Normalize a single floating point value using the squared root sum of square value
    calculated on the normilize vector method.

    - Parameter value: The floating point value to be normalized.
    - Returns: The normalized value.
    */
    public func normalize(_ value: T) -> T {
        guard let sqrootSumSquared = self.sqrootSumSquared else { return value }
        return value / sqrootSumSquared
    }

    /**
    Denormalize value method.

    De-normalize a single floating point value using the squared root sum of square value
    calculated on the normilize vector method.

    - Parameter value: The floating point value to be de-normalized.
    - Returns: The de-normalized value.
    */
    public func denormalize(_ value: T) -> T {
        guard let sqrootSumSquared = self.sqrootSumSquared else { return value }
        return value * sqrootSumSquared
    }
}
