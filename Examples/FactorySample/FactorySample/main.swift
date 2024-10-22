//
//  main.swift
//  AbstractFactories
//
//  Created by Bruno on 21/10/24.
//

import Foundation
import VariadicArgumentConstructable

struct Author {
    var name: String
    var age: Int
}

extension Author: VariadicArgumentConstructable {
    typealias ArgumentTypes = (String, Int)
    
    static func construct<each T>(_ args: repeat each T) throws -> Author {
        let (name, age) = try unpack(repeat each args)
        return Author(name: name, age: age)
    }
    
    static func construct<each T>(_ builder: Builder<repeat each T>) throws -> Author {
        try builder { parameters in
            Author(name: parameters.name, birthYear: parameters.birthYear)
        }
    }
}

protocol FactoryProtocol {
    func produce<Output: VariadicArgumentConstructable, each T>(_ value: repeat each T) throws -> Output
}

final class Factory: FactoryProtocol {
    func produce<Output: VariadicArgumentConstructable, each T>(_ value: repeat each T) throws -> Output {
        return try Output.construct(Builder(repeat each value))
    }
}

print(try! Author.construct("Uncle Bob", 72))

let abstractFactory = Factory()

let newAuthor: Author = try! abstractFactory.produce("Martin Fowler", 73)

print("Made with factory", newAuthor)
