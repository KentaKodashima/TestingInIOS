//
//  DogYearsPerformanceTests.swift
//  DogYearsPerformanceTests
//
//  Created by Kenta Kodashima on 2019-01-04.
//  Copyright © 2019 Razeware. All rights reserved.
//

import XCTest
@testable import DogYears

class DogYearsPerformanceTests: XCTestCase {
  
  override func setUp() {
    
  }
  
  override func tearDown() {
    
  }
  
  func testMenuLoadPerformance() {
    var menu = Menu()
    self.measure {
      menu.loadDefaultMenu()
    }
  }
  
}
