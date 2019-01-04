//
//  DogYearsUnitTests.swift
//  DogYearsUnitTests
//
//  Created by Kenta Kodashima on 2019-01-01.
//  Copyright © 2019 Razeware. All rights reserved.
//

import XCTest
// @testable keyword allows us to use private methods and properties
@testable import DogYears

class DogYearsUnitTests: XCTestCase {
  
  let calc = Calculator()
  var resData: Data? = nil
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testMenuFailing() {
    var menu = Menu()
    menu.loadMenu(path: "Dummy.plist")
    let count = menu.count
    XCTAssert(count == 0, "Menu load menu items for non-existent menu file")
  }
  
  func testAdd() {
    let result = calc.evaluate(op: "+", arg1: 2.0, arg2: 9.0)
    XCTAssert(result == 11.0, "Calculator add operation failed.")
  }
  
  func testSubtract() {
    let result = calc.evaluate(op: "-", arg1: 9.0, arg2: 2.0)
    XCTAssert(result == 7.0, "Calculator subtraction operation failed.")
  }
  
  func testResult() {
    let res1 = calc.evaluate(op: "+", arg1: 2.0, arg2: 2.0)
    let res2 = calc.result
    XCTAssert(res1 == res2, "Calculator displayed result does not match calculation result.")
  }
  
  func testClear() {
    calc.clear()
    let result = calc.result
    XCTAssert(result == 0.0, "Calculator clear operation failed.")
  }
  
  func testInfoLoading() {
    let url = "https://raw.githubusercontent.com/FahimF/Test/master/DogYears-Info.rtf"
    
    let session = MockSession()
    let client = HTTPClient(session: session)
    
    client.get(url: url) {
      (data, error) in
        self.resData = data
    }
    let pred = NSPredicate(format: "resData != nil")
    let exp = expectation(for: pred, evaluatedWith: self, handler: nil)
    let res = XCTWaiter.wait(for: [exp], timeout: 5.0)
    if res == XCTWaiter.Result.completed {
      XCTAssertNotNil(resData, "No data received from the server for InfoView content")
    } else {
      XCTAssert(false, "The call to get the URL ran into some other error")
    }
  }
  
// Before refactoring
//  func testInfoLoading() {
//    let sb = UIStoryboard(name: "Main", bundle: nil)
//    XCTAssertNotNil(sb, "Could not instantiate storyboard for Info View content loading")
//    guard let vc = sb.instantiateViewController(withIdentifier: "InformationView") as? InfoViewController else {
//      XCTAssert(false, "Could not instantiate view controller for Info View content loading")
//      return
//    }
//
//    // In order to avoid "Thread 1: Fatal error: Unexpectedly found nil while unwrapping an Optional value"
//    _ = vc.view
//
//    guard let txt = vc.txtInfo.text else {
//      XCTAssert(false, "Could not get initial text content for Info View content loading.")
//      return
//    }
//
//    vc.loadContent()
//    let pred = NSPredicate(format: "text != %@", txt)
//    let exp = expectation(for: pred, evaluatedWith: vc.txtInfo, handler: nil)
//    let result = XCTWaiter.wait(for: [exp], timeout: 5.0)
//    XCTAssert(result == XCTWaiter.Result.completed, "Loading content for Info View did not change text.")
//  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
