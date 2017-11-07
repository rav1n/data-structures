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

class Stack<Element> {
    private var array = [Element]()
    
    func push(element: Element) {
        array.append(element)
    }
    
    func pop() throws -> Element? {
        if array.isEmpty {throw StackError.emptyStack}
        let element = array.removeLast()
        return element
    }
    
    func top() throws -> Element? {
        if array.isEmpty {throw StackError.emptyStack}
        return array.last
    }

}


