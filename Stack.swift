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


class Stack {
    private var top = -1
    private var array = [Int]()
    
    func push(element: Int) {
        self.top += 1
        array.insert(element, at: self.top)
    }
    
    func pop() throws -> Int {
        
        if isEmpty() {throw StackError.emptyStack}
        
        let element = array.remove(at: self.top)
        self.top -= 1
        return element
    }
    
    func peek() throws -> Int {
        
        if isEmpty() {throw StackError.emptyStack}
        
        return array[self.top]
    }
    
    private func isEmpty() -> Bool {
        return (self.top == -1)
    }
}


