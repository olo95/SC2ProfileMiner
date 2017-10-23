//
//  SC2Router.swift
//  SC2SimpleNetworking
//
//  Created by Alexander Stolar on 31.07.2017.
//  Copyright © 2017 Alexander Stolar. All rights reserved.
//

import Foundation

enum SC2RouterMethods: Int {
  case profile = 0
  case ladders
  case matchHistory
  case ladder
  case achievements
  case rewards
    
  static let allRequests = [profile, ladders, matchHistory, ladder, achievements, rewards]
  var string: String {
    switch self {
    case .profile:
      return "profile"
    case .ladders:
      return "ladders"
    case .matchHistory:
      return "matches"
    case .ladder:
      return "ladder"
    case .achievements:
      return "achievements"
    case .rewards:
      return "rewards"
    }
  }
  
}

struct SC2RouterConstants {
  static let baseUrl = "https://eu.api.battle.net/sc2/"
  static let apiKey = "eac66ywyf7bydjp5dqjsz4amudm69s4k"
  static let region = "1"
  static let locale = "pl_PL"
}

struct SC2RouterKeys {
  static let profile = "profile"
  static let ladder = "ladder"
  static let data = "data"
  
  static let ladders = "ladders"
  static let matches = "matches"
  static let achievements = "achievements"
  static let rewards = "rewards"
  static let region = "region"
  static let locale = "locale"
  static let apiKey = "apikey"
  static let name = "name"
  static let id = "id"
}

struct SC2Url {
  var name = ""
  var id = ""
}

class SC2Router {
  
  static func getUrl(parameters: SC2Url, method: SC2RouterMethods) -> String {

    switch method {
        case .profile:
          return "\(SC2RouterConstants.baseUrl)\(SC2RouterKeys.profile)/\(parameters.id)/\(SC2RouterConstants.region)/\(parameters.name)/?\(SC2RouterKeys.locale)=\(SC2RouterConstants.locale)&\(SC2RouterKeys.apiKey)=\(SC2RouterConstants.apiKey)"
        case .ladders:
          return "\(SC2RouterConstants.baseUrl)\(SC2RouterKeys.profile)/\(parameters.id)/\(SC2RouterConstants.region)/\(parameters.name)/\(SC2RouterKeys.ladders)?\(SC2RouterKeys.locale)=\(SC2RouterConstants.locale)&\(SC2RouterKeys.apiKey)=\(SC2RouterConstants.apiKey)"
        case .matchHistory:
          return "\(SC2RouterConstants.baseUrl)\(SC2RouterKeys.profile)/\(parameters.id)/\(SC2RouterConstants.region)/\(parameters.name)/\(SC2RouterKeys.matches)?\(SC2RouterKeys.locale)=\(SC2RouterConstants.locale)&\(SC2RouterKeys.apiKey)=\(SC2RouterConstants.apiKey)"
    case .ladder:
      return "\(SC2RouterConstants.baseUrl)\(SC2RouterKeys.ladder)/\(parameters.id)?\(SC2RouterKeys.locale)=\(SC2RouterConstants.locale)&\(SC2RouterKeys.apiKey)=\(SC2RouterConstants.apiKey)"
        case .achievements:
          return "\(SC2RouterConstants.baseUrl)\(SC2RouterKeys.data)/\(SC2RouterKeys.achievements)?\(SC2RouterKeys.locale)=\(SC2RouterConstants.locale)&\(SC2RouterKeys.apiKey)=\(SC2RouterConstants.apiKey)"
        case .rewards:
          return "\(SC2RouterConstants.baseUrl)\(SC2RouterKeys.data)/\(SC2RouterKeys.rewards)?\(SC2RouterKeys.locale)=\(SC2RouterConstants.locale)&\(SC2RouterKeys.apiKey)=\(SC2RouterConstants.apiKey)"
    }
  }
}
