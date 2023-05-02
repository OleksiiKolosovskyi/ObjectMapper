//
//  ISO8601DateTransform.swift
//  ObjectMapper
//
//  Created by Jean-Pierre Mouilleseaux on 21 Nov 2014.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014-2018 Tristan Himmelman
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

class ISO8601DateTransform : TransformType {
    typealias Object = Date
    typealias JSON = String
    
    
    let dateFormatter: DateFormatter = DateFormatter()
    
    
    init() {
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    }
    
    
    private func check(withFormat format: String, string dateStr: String) -> Date? {
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: dateStr)
    }

    
    func transformFromJSON(_ value: Any?) -> Date? {
        if let dateString = value as? String {
            if let date = check(withFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", string: dateString) {
                return date
                
            } else if let date = check(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", string: dateString) {
                return date
                
            } else if let date = check(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", string: dateString) {
                return date
            }
        }
        
        return nil
    }
    
    
    func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            return dateFormatter.string(from: date)
        }
        
        return nil
    }
}
