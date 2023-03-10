//
//  TestDemo.swift
//  TestDemo
//
//  Created by 沙睿 on 2022/5/31.
//

import XCTest
class TestDemo: XCTestCase {

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    func test_739_每日温度() {
        let result = _739_每日温度().dailyTemperatures([55,38,53,81,61,93,97,32,43,78])
        assert(result == [3, 1, 1, 2, 1, 1, 0, 1, 1, 0])
    }
    
    func test_242_有效的字母异位词() {
        let result = _242_有效的字母异位词().isAnagram("anagram", "nagaram")
        assert(result == true)

    }

}
