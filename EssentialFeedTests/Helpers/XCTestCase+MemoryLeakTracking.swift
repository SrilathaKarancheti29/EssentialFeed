//
//  XCTestCase+MemoryLeakTracking.swift
//  NetworkingTests
//
//  Created by Srilatha Karancheti on 2022-04-30.
//

import XCTest

extension XCTestCase {
    func trackMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated.Potential memory leak.", file: file, line: line)
        }
    }
}
