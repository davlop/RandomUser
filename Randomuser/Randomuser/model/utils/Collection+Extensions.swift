//
//  Collection+Extensions.swift
//  Randomuser
//
//  Created by David Lopez on 19/9/22.
//

import Foundation

// The purpose of these extensions is to avoid indexOutOfBounds crashes when accessing a collection's element by its index

// Reference: https://stackoverflow.com/a/48103917
extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

// Reference: https://stackoverflow.com/a/48103917
extension MutableCollection {
    subscript(safe index: Index) -> Element? {
        get {
            return indices.contains(index) ? self[index] : nil
        }

        set(newValue) {
            guard let newValue = newValue, indices.contains(index) else { return }
            self[index] = newValue
        }
    }
}
