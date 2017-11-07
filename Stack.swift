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

struct Stack<Element> {
    private var array = [Element]()
    
    mutating func push(element: Element) {
        array.append(element)
    }
    
    mutating func pop() throws -> Element? {
        if array.isEmpty {throw StackError.emptyStack}
        let element = array.removeLast()
        return element
    }
    
    func top() throws -> Element? {
        if array.isEmpty {throw StackError.emptyStack}
        return array.last
    }

    func description() {
        print(self.array, separator: "-->", terminator: "\n")
    }
}


