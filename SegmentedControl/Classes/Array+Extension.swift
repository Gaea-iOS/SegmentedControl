//
//  Array+Extension.swift
//  Pods
//
//  Created by 王小涛 on 2016/12/20.
//
//

import Foundation

public extension Array {
    func forEach(_ body: (Element, Int) throws -> Void) rethrows {
        try (0..<count).forEach { try body(self[$0], $0)}
    }
}

public extension Array where Element: Equatable {
    func filter(_ isIncluded: (Element, Int) throws -> Bool) rethrows -> [Element] {
        return try filter { try isIncluded($0, index(of: $0)!) }
    }
}
