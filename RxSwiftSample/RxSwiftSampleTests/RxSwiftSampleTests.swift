//
//  RxSwiftSampleTests.swift
//  RxSwiftSampleTests
//
//  Created by Hirohisa Kawasaki on 8/5/15.
//  Copyright (c) 2015 Hirohisa Kawasaki. All rights reserved.
//

import UIKit
import XCTest
import RxSwift

class RxSwiftSampleTests: XCTestCase {

    func testZip1() {

        let v0 = Variable(0)
        let v1 = Variable(1)

        var result: Int = 0
        zip(v0, v1) { (a0, a1) in a0 + a1 } >- subscribeNext { result = $0 }

        XCTAssertEqual(result, 1)

    }

    func testZip2() {

        let v0 = Variable(0)
        let v1 = Variable(1)

        var result: Int = 0
        let o = zip(v0, v1) { (a0, a1) in a0 + a1 }
        let d = o >- subscribeNext { result = $0 }
        o >- subscribeNext { println($0) }

        XCTAssertEqual(result, 1)

        v0.next(2)
        v1.next(3)

        XCTAssertEqual(result, 5)

        d.dispose()

        v0.next(1)
        v1.next(1)

        XCTAssertEqual(result, 5)

    }

}
