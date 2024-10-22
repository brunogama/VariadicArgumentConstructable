//
//  TuplePairGenerator.swift
//  VariadicArgumentConstructable
//
//  Created by Bruno on 20/10/24.
//

import Foundation

protocol RandomValue: Sendable {}

extension String: RandomValue {}
extension Float: RandomValue {}
extension Bool: RandomValue {}
extension Int: RandomValue {}
extension Double: RandomValue {}


struct Pair<A: Sendable, B: Sendable>: Sendable {
    let left: A
    let right: B
    
    init(
        _ left: A,
        _ right: B
    ) {
        self.left = left
        self.right = right
    }
}


