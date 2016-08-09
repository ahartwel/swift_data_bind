//
//  DataBindTests.swift
//  DataBindTests
//
//  Created by Alex Hartwell on 8/8/16.
//  Copyright © 2016 Alex Hartwell. All rights reserved.
//

import XCTest
@testable import DataBind

class TestModel {
    var name: DataBindType = DataBindType<String>(value: "Al");
}

class TestView {
    var label: String = "";
    var cb: (String -> ()) = { string in };

    lazy var firstListener: Listener<String> = Listener<String>(listener: self.cb);
    lazy var listenerRefferingToFunc: Listener<String> = Listener<String>(listener: self.callback);
    
    init() {
        
    }
    
    func getListener(cb: (String -> ())) -> Listener<String> {
        let listener: Listener<String> = Listener<String>(listener: cb);
        return listener;
    }
    
    func callback(string: String) {
        print(string);
        self.label = string;
    }
    
}

class DataBindTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatViewGetsCallback() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectation = expectationWithDescription("...");

        let model = TestModel();
        let view: TestView? = TestView();
        view!.cb = {
            string in
            print(string);
            view!.label = string;
            if (view!.label == model.name.get()) {
                expectation.fulfill();
            }
        };
        
        let bindee = DataBind<String>.getBindee(view!.firstListener);
        model.name.addBindee(bindee);
        model.name.set("Alex");
        waitForExpectationsWithTimeout(10) { error in
            // ...
        }
    }
    
    func testIfBindeeIsDeleted() {
        let model = TestModel();
        var view: TestView? = TestView();
        let bindee: DataBindee = DataBind<String>.getBindee(view!.listenerRefferingToFunc);
        model.name.addBindee(bindee);
        model.name.set("WHAATT!!!>>!>!?!?!");
        view = nil;
        model.name.set("Whaatt?");
    }

    
}
