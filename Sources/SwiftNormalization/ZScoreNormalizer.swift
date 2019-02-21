/**
 ZScore Vector Normalizer.

 Formula: x' = (x' - MEAN(X)) / STD(X)
 */
public struct ZScoreNormalizer<T: BinaryFloatingPoint> : Normalizer {
    public typealias VectorType = T

    var meanAverage: T?
    var standardDeviation: T?

    /**
    Normalized vector method.

    Normalize a floating point vector saving meanAverage and standardDeviation values of the vector.
    These internal state information are needed to later normalize and de-normalize sigle values

    - Parameter vector: The floating point one dimension array to be normalized.
    - Returns: The normalized one dimension array.
    */
    public mutating func normalized(_ vector: [T]) -> [T] {
        let meanAverage = mean(vector)
        let standardDeviation = std(vector)
        self.meanAverage = meanAverage
        self.standardDeviation = standardDeviation

        return vector.map{ ($0 - meanAverage) / standardDeviation }
    }

    /**
    Normalize value method.

    Normalize a single floating point value using the meanAverage and standardDeviation values
    calculated on the normilize vector method.

    - Parameter value: The floating point value to be normalized.
    - Returns: The normalized value.
    */
    public func normalize(_ value: T) -> T {
        guard let meanAverage = self.meanAverage, let standardDeviation = self.standardDeviation else { return value }
        return (value - meanAverage) / standardDeviation
    }

    /**
    Denormalize value method.

    De-normalize a single floating point value using the meanAverage and standardDeviation values
    calculated on the normilize vector method.

    - Parameter value: The floating point value to be de-normalized.
    - Returns: The de-normalized value.
    */
    public func denormalize(_ value: T) -> T {
        guard let meanAverage = self.meanAverage, let standardDeviation = self.standardDeviation else { return value }
        return (value * standardDeviation) + meanAverage
    }
}
