//
// Utilities.swift
// Teddy Compiler
//
// Created on 2/16/17.
// Copyright (c) 2017 Janum Trivedi (http://janumtrivedi.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

private var expressions = [String: NSRegularExpression]()

public extension String {
    
    public func match(regex: String) -> String? {
        let expression: NSRegularExpression
        if let exists = expressions[regex] {
            expression = exists
        }
        else {
            expression = try! NSRegularExpression(pattern: "^\(regex)", options: [])
            expressions[regex] = expression
        }
        
        let range = expression.rangeOfFirstMatch(in: self, options: [], range: NSMakeRange(0, utf16.count))
        if range.location != NSNotFound {
            return (self as NSString).substring(with: range)
        }
        
        return nil
    }
    
    public func trimLast() -> String {
        return self.substring(to: self.index(before: self.endIndex))
    }
    
    public func camelCased() -> String {
        let first = String(characters.prefix(1)).lowercased()
        let other = String(characters.dropFirst())
        return first + other
    
    }
    
    public static func returnCommentHeader(text: String, width: Int = 100) -> IR {
        var IR = "/*\n"
        
        IR.append(String(repeating: "-", count: width))
        IR.append("\n")
        
        IR.append(String(repeating: " ", count: width))
        IR.append("\n")
        
        let padding = (width - text.characters.count) / 2
        
        IR.append(String(repeating: " ", count: padding))
        IR.append(text)
    
        IR.append(String(repeating: " ", count: padding))
        IR.append("\n")
        
        IR.append(String(repeating: " ", count: width))
        IR.append("\n")
        
        IR.append(String(repeating: "-", count: width))
        IR.append("\n*/\n")
        
        return IR
    }
    
    public static func printHeader(text: String, width: Int = 100) {
        
        print(String(repeating: "-", count: width));
        print(String(repeating: " ", count: width));
        
        let padding = (width - text.characters.count) / 2
        
        print(String(repeating: " ", count: padding), terminator: "")
        print(text, terminator: "")
        print(String(repeating: " ", count: padding))
        
        print(String(repeating: " ", count: width));
        print(String(repeating: "-", count: width));
        
        print()
    }
    
}
