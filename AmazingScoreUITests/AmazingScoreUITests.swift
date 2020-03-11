//
//  AmazingScoreUITests.swift
//  AmazingScoreUITests
//
//  Created by Carmine Del Gaudio on 10/03/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import XCTest

class AmazingScoreUITests: XCTestCase {
  
  func testExample() {
    let app = XCUIApplication()
    app.launch()
    
    let title = app.staticTexts["creditScoreTitle"]
    let subTitle = app.staticTexts["creditScoreSubtitle"]
    let score = app.staticTexts["creditScoreValue"]
    
    XCTAssertTrue(title.exists)
    XCTAssertTrue(subTitle.exists)
    XCTAssertTrue(score.exists)
    
  }
  
}


