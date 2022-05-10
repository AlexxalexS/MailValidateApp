//
//  Collection + Extension.swift
//  MailValidate
//
//  Created by Leha on 10.05.2022.
//

import Foundation

extension Collection {

    /// Returns the position immediately after the given index, if that position
    /// exists and points to a valid element.
    ///
    /// - Parameter i: A valid index of the collection.
    /// - Returns: The index value immediately after `i`, unless that would be
    ///   at or past `endIndex`, then `nil`.
    public func elementIndex(after i: Index) -> Index? {
        let end = endIndex
        guard i < end else { return nil }

        let result = index(after: i)
        return result != end ? result : nil
    }

    /// Returns the position that is the specified distance from the given
    /// index, as long as that position exists and points to a valid element.
    ///
    /// - Parameters:
    ///    - i: A valid index of the collection.
    ///    - distance: The distance to offset `i`.  `distance` must not be
    ///      negative unless the collection conforms to the
    ///      `BidirectionalCollection` protocol.
    /// - Returns: A value *x* such that `distance(from: i, to: x)` is parameter
    ///   `distance`, as long as `x` would be within `startIndex..<endIndex`;
    ///   otherwise, `nil`.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the absolute
    ///   value of `distance`.
    public func elementIndex(_ i: Index, offsetBy distance: Int) -> Index? {
        let end = endIndex
        guard distance != 0 else { return i != end ? i : nil }

        if distance > 0 {
            let result = index(i, offsetBy: distance, limitedBy: end)
            return result != end ? result : nil
        } else {
            return index(i, offsetBy: distance, limitedBy: startIndex)
        }
    }

}

extension BidirectionalCollection {

    /// Returns the position immediately before the given index, if that position
    /// position exists.
    ///
    /// - Parameter i: A valid index of the collection.
    /// - Returns: The index value immediately before `i`, unless that would be
    ///   past `startIndex`, then `nil`.
    func elementIndex(before i: Index) -> Index? {
        guard i > startIndex else { return nil }

        return index(before: i)
    }

}
