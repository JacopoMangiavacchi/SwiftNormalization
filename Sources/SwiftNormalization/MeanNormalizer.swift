/**
 Mean Vector Normalizer.

 Formula: x' = (x' - mean) / (max - min)
 Normalized values: -0.5 <= x' <= 0.5
 */
public struct MeanNormalizer<T: BinaryFloatingPoint> : Normalizer {
    public typealias VectorType = T

    var min: T?
    var max: T?
    var meanAverage: T?

    /**
    Init the normalizer with no state.

    The state will be detected calling the normalized method.
    */
    public init() {
    }

    /**
    Init the normalizer with min, max and meanAverage state.

    These state values will be overwritten by a call to the normalized method. 

    - Parameter min: The min floating point value to be used for normalize and denormalize methods.
    - Parameter max: The max floating point value to be used for normalize and denormalize methods.
    - Parameter meanAverage: The meanAverage floating point value to be used for normalize and denormalize methods.
    */
    public init(min: T, max: T, meanAverage: T) {
        self.min = min
        self.max = max
        self.meanAverage = meanAverage
    }

    /**
    Normalized vector method.

    Normalize a floating point vector saving min, max and mean values of the vector.
    These internal state information are needed to later normalize and de-normalize sigle values

    - Parameter vector: The floating point one dimension array to be normalized.
    - Returns: The normalized one dimension array.
    */
    public mutating func normalized(_ vector: [T]) -> [T] {
        guard let (min, max) = minMax(vector) else { return vector }
        let meanAverage = mean(vector)
        self.min = min
        self.max = max
        self.meanAverage = meanAverage

        return vector.map{ ($0 - meanAverage) / (max - min) }
    }

    /**
    Normalize value method.

    Normalize a single floating point value using the min, max and mean values
    calculated on the normilize vector method.

    - Parameter value: The floating point value to be normalized.
    - Returns: The normalized value.
    */
    public func normalize(_ value: T) -> T {
        guard let min = self.min, let max = self.max, let meanAverage = self.meanAverage else { return value }
        return (value - meanAverage) / (max - min)
    }

    /**
    Denormalize value method.

    De-normalize a single floating point value using the min, max and mean values
    calculated on the normilize vector method.

    - Parameter value: The floating point value to be de-normalized.
    - Returns: The de-normalized value.
    */
    public func denormalize(_ value: T) -> T {
        guard let min = self.min, let max = self.max, let meanAverage = self.meanAverage else { return value }
        return (value * (max - min)) + meanAverage
    }
}
