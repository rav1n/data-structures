//
//  Stack.swift
//  GettingStarted
//
//  Created by Ravindra on 06/11/17.
//  Copyright © 2017 Ravindra. All rights reserved.
//

import Foundation

enum StackError: Error {
    case emptyStack
}

struct Stack<Element> : CustomStringConvertible {

    private var array = [Element]()

    public var count: Int { return self.array.count }
    public var isEmpty: Bool { return self.array.isEmpty }
    public var description: String {
        return self.array.reversed().reduce("Stack[Top:]"){"\($0) --> \($1)"}
    }
    
    public mutating func push(element: Element) { self.array.append(element) }
    
    public mutating func pop() throws -> Element? {
        if array.isEmpty { throw StackError.emptyStack }
        let element = array.removeLast()
        return element
    }
    
    public func top() throws -> Element? {
        if self.array.isEmpty { throw StackError.emptyStack }
        return self.array.last
    }
}

extension Stack {
    
    enum MergeStrategy {
        case oneByOne
        case allAtOnce
    }
    
    func reversed() -> Stack<Element> {
        let nArray = self.array.reversed()
        var nStack = Stack<Element>()
        
        for i in 0 ..< nArray.count {
            let idx = nArray.index(nArray.startIndex, offsetBy: i)
            nStack.push(element: nArray[idx])
        }
        
        return nStack
    }
    
    func merge(_ otherStack: Stack<Element>, strategy: Stack.MergeStrategy = .oneByOne) -> Stack<Element> {
        var nStack = self
        var other = otherStack
        switch strategy {
        case .oneByOne: other = otherStack
        case .allAtOnce: other = otherStack.reversed()
        }
        
        while !other.isEmpty {
            if let top = try? other.pop() {
                guard let topElement = top  else { break }
                nStack.push(element: topElement)
            }
        }
        return nStack
    }
}


