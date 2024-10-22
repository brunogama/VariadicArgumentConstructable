//
//  PairGeneratorFactory.swift
//  VariadicArgumentConstructable
//
//  Created by Bruno on 21/10/24.
//


import Foundation

struct RandomGeneratorFactory: Sendable {
    
    enum SwiftType: String, CaseIterable, Sendable {
        case string = "String"
        case int = "Int"
        case double = "Double"
        case bool = "Bool"
        case float = "Float"
    }
    
    static let shared = RandomGeneratorFactory()
    
    func randomString() -> any RandomValue {
        let length = Int.random(in: 1...10)
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }
    
    func randomInt() -> Int {
        Int.random(in: -1000...1000)
    }
    
    func randomDouble() -> Double {
        Double.random(in: -1000...1000)
    }
    
    func randomBool() -> Bool {
        Bool.random()
    }
    
    func randomFloat() -> Float {
        return Float.random(in: -1000...1000)
    }
    
    func randomList(of type: SwiftType, count: Int = 10) -> [RandomValue] {
        (0...count).map { _ in
            generateRandomValue(of: type)
        }
    }
  
    private func generateRandomValue(of type: SwiftType) -> RandomValue {
        switch type {
        case .string:
            return randomString()
        case .int:
            return randomInt()
        case .double:
            return randomDouble()
        case .bool:
            return randomBool()
        case .float:
            return randomFloat()
        }
    }
    
    private func generateRandomValue(excluding: [SwiftType] = []) -> RandomValue {
        
        let availableTypes = SwiftType.allCases.reduce(into: [SwiftType]()) { result, type in
            if !excluding.contains(type) {
                result.append(type)
            }
        }
        let type = availableTypes.randomElement() ?? .bool
        switch type {
        case .string:
            return randomString()
        case .int:
            return randomInt()
        case .double:
            return randomDouble()
        case .bool:
            return randomBool()
        case .float:
            return randomFloat()
        }
    }
    
    func generateRandonPairs(
        ignoreTypes: [SwiftType] = []
    ) -> [Pair<RandomValue, RandomValue>] {
        let result: [Pair<RandomValue, RandomValue>] = (1...5).map { _ in
            Pair(generateRandomValue(excluding: ignoreTypes), generateRandomValue(excluding: ignoreTypes))
        }
        return result
    }
}
