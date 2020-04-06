//
//  AmazingScoreTests.swift
//  AmazingScoreTests
//
//  Created by Carmine Del Gaudio on 10/03/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import XCTest
@testable import AmazingScore

class DashboardTests: XCTestCase {
  
  func testFailure() {
    let viewState = Binder<DashboardViewState>(value: .failed(errorMessage: ""))
    let viewModel = DashboardViewModel(network: MockNetwork(.failure), viewState: viewState)
    viewModel.start()
    switch viewState.value {
    case .failed:
      XCTAssert(true)
    default:
      XCTAssert(false)
    }
  }
  
  func testLoading() {
    let viewState = Binder<DashboardViewState>(value: .failed(errorMessage: ""))
    let viewModel = DashboardViewModel(network: MockNetwork(.loading), viewState: viewState)
    viewModel.start()
    switch viewState.value {
    case .loading:
      XCTAssert(true)
    default:
      XCTAssert(false)
    }
  }
  
  func testLoaded() {
    let viewState = Binder<DashboardViewState>(value: .failed(errorMessage: ""))
    let viewModel = DashboardViewModel(network: MockNetwork(.loaded(.mock)), viewState: viewState)
    viewModel.start()
    switch viewState.value {
    case .loaded(let state):
      XCTAssert(state.score == 514)
    default:
      XCTAssert(false)
    }
  }
}

extension AccountResponse {
  static let mock: AccountResponse = {
    try! JSONDecoder().decode(AccountResponse.self, from: mockJson!)
  }()
}

// usually I move this in a separate JSON file but in this app there is only 1 response
private let mockJson: Data? = """
{
"accountIDVStatus": "PASS",
"creditReportInfo": {
"score": 514,
"scoreBand": 4,
"clientRef": "CS-SED-655426-708782",
"status": "MATCH",
"maxScoreValue": 700,
"minScoreValue": 0,
"monthsSinceLastDefaulted": -1,
"hasEverDefaulted": false,
"monthsSinceLastDelinquent": 1,
"hasEverBeenDelinquent": true,
"percentageCreditUsed": 44,
"percentageCreditUsedDirectionFlag": 1,
"changedScore": 0,
"currentShortTermDebt": 13758,
"currentShortTermNonPromotionalDebt": 13758,
"currentShortTermCreditLimit": 30600,
"currentShortTermCreditUtilisation": 44,
"changeInShortTermDebt": 549,
"currentLongTermDebt": 24682,
"currentLongTermNonPromotionalDebt": 24682,
"currentLongTermCreditLimit": null,
"currentLongTermCreditUtilisation": null,
"changeInLongTermDebt": -327,
"numPositiveScoreFactors": 9,
"numNegativeScoreFactors": 0,
"equifaxScoreBand": 4,
"equifaxScoreBandDescription": "Excellent",
"daysUntilNextReport": 9
},
"dashboardStatus": "PASS",
"personaType": "INEXPERIENCED",
"coachingSummary": {
"activeTodo": false,
"activeChat": true,
"numberOfTodoItems": 0,
"numberOfCompletedTodoItems": 0,
"selected": true
},
"augmentedCreditScore": null
}
""".data(using: .utf8)
