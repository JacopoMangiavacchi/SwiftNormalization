/**
 Normalizer protocol.

 Methods to normalize a floating point vector and normailize/de-normalize
 single values based on the information calculated during the vector normalization.
 */
public protocol Normalizer {
    associatedtype VectorType

    /**
    Normalized vector method.

    Normalize a floating point vector saving on mutable state internal properties
    the information needed to later normalize and de-normalize sigle values

    - Parameter vector: The floating point one dimension array to be normalized.
    - Returns: The normalized one dimension array.
    */
    mutating func normalized(_ vector: [VectorType]) -> [VectorType]

    /**
    Normalize value method.

    Normalize a single floating point value using the state internal properties
    calculated on the normilize vector method.

    - Parameter value: The floating point value to be normalized.
    - Returns: The normalized value.
    */
    func normalize(_ value: VectorType) -> VectorType

    /**
    Denormalize value method.

    De-normalize a single floating point value using the state internal properties
    calculated on the normilize vector method.

    - Parameter value: The floating point value to be de-normalized.
    - Returns: The de-normalized value.
    */
    func denormalize(_ value: VectorType) -> VectorType
}
