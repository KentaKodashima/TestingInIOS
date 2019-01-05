//
//  DogYearsUITests.swift
//  DogYearsUITests
//
//  Created by Kenta Kodashima on 2019-01-04.
//  Copyright © 2019 Razeware. All rights reserved.
//

import XCTest

class DogYearsUITests: XCTestCase {
  
  private var app: XCUIApplication!
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    app = XCUIApplication()
    app.launch()
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testNavigationBackToMenu() {
    navigateBack()
    
    let nav = app.navigationBars["Menu"]
    XCTAssert(nav.exists, "The new navigationn bar does not exist.")
  }
  
  func testInformationScreen() {
    navigateBack()
    
    app.tables/*@START_MENU_TOKEN@*/.staticTexts["Information"]/*[[".cells.staticTexts[\"Information\"]",".staticTexts[\"Information\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    let nav = app.navigationBars["Information"]
    XCTAssert(nav.exists, "Information navigation does not exist.")
  }
  
  func testSettingNavigation() {
    navigateBack()
    
    app.tables.staticTexts["Settings"].tap()
    let nav = app.navigationBars["Settings"]
    XCTAssert(nav.exists, "Settings navigation does not exist.")
  }
  
  func testAboutNavigation() {
    navigateBack()
    
    app.tables.staticTexts["About"].tap()
    let nav = app.navigationBars["About"]
    XCTAssert(nav.exists, "About navigation does not exist.")
  }
  
  func testCalculatorEntry() {
    let display = app.staticTexts.matching(identifier: "result").firstMatch
    app.buttons["2"].tap()
    app.buttons["4"].tap()
    XCTAssert(display.label == "24", "The calculator display value did not change.")
  }
  
  func testRateThisAppFeature() {
    let tablesQuery = app.tables
    tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["About"]/*[[".cells.staticTexts[\"About\"]",".staticTexts[\"About\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    tablesQuery/*@START_MENU_TOKEN@*/.buttons["Rate Us On the App Store"]/*[[".cells.buttons[\"Rate Us On the App Store\"]",".buttons[\"Rate Us On the App Store\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    let element = app.children(matching: .other).element(boundBy: 0)
    
    let pred = NSPredicate(format: "exists == true")
    let exp = expectation(for: pred,  evaluatedWith: element, handler: nil)
    let res = XCTWaiter.wait(for: [exp], timeout: 5.0)
    XCTAssert(res == XCTWaiter.Result.completed, "Failed time out waiting for rate dialog")
    
    let title = element.staticTexts["Enjoying DogYears?"]
    XCTAssert(title.exists, "Enjoying DogYears dialog did not show!")
    element.staticTexts["Not Now"].tap()
    XCTAssert(title.exists, "Enjoying DogYears dialog did not go away!")
  }
  
  func isPad() -> Bool {
    return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
  }
  
  func isPortrait() -> Bool {
    return XCUIDevice.shared.orientation.isPortrait
  }
  
  func navigateBack() {
    if isPad() {
      if isPortrait() {
        app.buttons["Master"].tap()
      }
    } else {
      app.navigationBars["Master"].buttons["Menu"].tap()
    }
  }
}
