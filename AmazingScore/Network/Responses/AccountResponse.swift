//
//  AccountResponse.swift
//  AmazingScore
//
//  Created by Carmine Del Gaudio on 10/03/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

// MARK: AccountResponse
struct AccountResponse: Codable {
  
  // MARK: CoachingSummary
  struct CoachingSummary: Codable {
    let activeTodo: Bool
    let activeChat: Bool
    let numberOfTodoItems: Int
    let numberOfCompletedTodoItems: Int
    let selected: Bool
  }
  
  // MARK: CreditReportInfo
  struct CreditReportInfo: Codable {
    let score: Int
    let scoreBand: Int
    let clientRef: String
    let status: String
    let maxScoreValue: Int
    let minScoreValue: Int
    let monthsSinceLastDefaulted: Int
    let hasEverDefaulted: Bool
    let monthsSinceLastDelinquent: Int
    let hasEverBeenDelinquent: Bool
    let percentageCreditUsed: Int
    let percentageCreditUsedDirectionFlag: Int
    let changedScore: Int
    let currentShortTermDebt: Int
    let currentShortTermNonPromotionalDebt: Int
    let currentShortTermCreditLimit: Int
    let currentShortTermCreditUtilisation: Int
    let changeInShortTermDebt: Int
    let currentLongTermDebt: Int
    let currentLongTermNonPromotionalDebt: Int
    let changeInLongTermDebt: Int
    let numPositiveScoreFactors: Int
    let numNegativeScoreFactors: Int
    let equifaxScoreBand: Int
    let equifaxScoreBandDescription: String
    let daysUntilNextReport: Int
  }
  
  // MARK: -
  let accountIDVStatus: String
  let creditReportInfo: CreditReportInfo
  let dashboardStatus: String
  let personaType: String
  let coachingSummary: CoachingSummary
}


