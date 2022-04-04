//
//  FlowTest.swift
//  iOEngineTests
//
//  Created by Richard Christopher on 4/2/22.
//

import Foundation
import XCTest

@testable import iOEngine

class iOEngTest: XCTestCase {
    
    let router = RouterSpy()

    
    func start_blank_test(){
        makeSysTest(initVals: []).start()
        XCTAssertTrue(router.routedVals.isEmpty)
    }

    func start_blank_test_with_val(){
        makeSysTest(initVals: ["V1"]).start()
        XCTAssertEqual(router.routedVals, ["V1"])
    }
    
    func start_blank_test_with_vals(){
        makeSysTest(initVals: ["V1", "V2"]).start()
        XCTAssertEqual(router.routedVals, ["V1", "V2"])
    }
    
    func start_blank_test_with_vals_twice(){
        let systest = makeSysTest(initVals: ["V1", "V2"])
        systest.start()
        systest.start()
        XCTAssertEqual(router.routedVals, ["V1", "V1"])
    }
    
    func start_and_answer_with_route(){
        makeSysTest(initVals: ["V1", "V1"]).start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routedVals, ["V1", "V2"])
    }
    
    func start_and_answer_multiple() {
        makeSysTest(initVals: ["V1", "V2", "V3"]).start()
        
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedVals, ["V1", "V2", "V3"])
    }
    
    func start_and_answer_one() {
        makeSysTest(initVals: ["V1"]).start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routedVals, ["V1"])
    }
    
    // MARK: Helpers
    
    func makeSysTest(initVals: [String]) -> iOEng{
        return iOEng(initVals: initVals, router: router)
    }
    
    
    class RouterSpy: Router {
        var routedVals: [String] = []
        var answerCallback: ((String) -> Void) = { _ in }
        
        func routeTo(initVal: String, answerCallback: @escaping Router.AnswerCallback) {
            routedVals.append(initVal)
        }
    }
}
