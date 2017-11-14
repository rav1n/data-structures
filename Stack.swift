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
    
    //MARK: Initializer
    // Initializes stack with given array elements
    init(_ array: [Element] = []) {
        self.array = array
    }

    //MARK: Primary API
    public var count: Int { return self.array.count }
    public var isEmpty: Bool { return self.array.isEmpty }
    public var description: String {
        return self.array.reversed().reduce("\(type(of: self))>[Top:]"){"\($0) --> \($1)"}
    }
    
    public mutating func push(element: Element) { self.array.append(element) }
    
    public mutating func pop() throws -> Element? {
        if array.isEmpty { throw StackError.emptyStack }
        let element = array.popLast()
        return element
    }
    
    public func top() throws -> Element? {
        if self.array.isEmpty { throw StackError.emptyStack }
        return self.array.last
    }
}

//MARK: Merge Support
extension Stack {
    
    //  These merge strategy result in different outcome see comments for further details
    enum MergeStrategy {
        case oneByOne   // element are picked from one stack and pushed on another stack one at a time
        case allAtOnce  // whole stack is pushed on another stack in one go
    }
    
    //  Returns reversed stack
    func reversed() -> Stack<Element> {
        let nArray = self.array.reversed()
        var nStack = Stack<Element>()
        
        for i in 0 ..< nArray.count {
            let idx = nArray.index(nArray.startIndex, offsetBy: i)
            nStack.push(element: nArray[idx])
        }
        
        return nStack
    }
    
    /*
     *  Returns merged stack based on given strategy [default strategy is oneByOne]
     *
     *  [with onByOne] strategy element is popped from incoming stack and pushed to received stack
     *  consider it as lifting one dish from a stack and placing it on another stack one at a time
     *     example:
     *          self = Top[1,2,3] and incoming = Top[4,5,6,7]
     *          then merge result will be [7,6,5,4,1,2,3]
     *
     *  [with allAtOnce] strategy whole incoming stack(as a single block) is pushed to received stack
     *  consider it as lifting a stack of dishes all at once and placing them on another stack
     *     example:
     *          self = Top[1,2,3] and incoming = Top[4,5,6,7]
     *          then merge result will be [4,5,6,7,1,2,3]
     */
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
