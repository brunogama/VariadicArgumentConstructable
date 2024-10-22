//
//  Builder.swift
//  VariadicArgumentConstructable
//
//  Created by Bruno on 22/10/24.
//

@available(macOS 14.0.0, *)
public struct Builder<each T> {
    var item: (repeat each T)
    
    init(_ item: repeat each T) {
        self.item = (repeat each item)
    }
    
    func callAsFunction<Out: VariadicArgumentConstructable>(
        _ f: @escaping (_ args: Out.ArgumentTypes) -> Out
    ) throws -> Out {
        let tuple = (repeat each item)
        guard let castedTuple = tuple as? Out.ArgumentTypes else {
            throw InvalidConstructionArgumentTypestionError(expected: Out.ArgumentTypes.self, actual: type(of: tuple))
        }
        return f(castedTuple)
    }
}
