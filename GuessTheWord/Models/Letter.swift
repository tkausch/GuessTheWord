///
/// Copyright (c) 2022 Thomas Kausch
///
///
import Foundation
import SwiftUI

enum LetterStatus: String {
  case undedfined = "Undefined"
  case notInWord = "Not in Word"
  case notInPosition = "In Word, But Not This Position"
  case inPosition = "Correct and In Position"
}

struct Letter: Identifiable {
  var id = UUID()
  var letter: String
  var status: LetterStatus = .undedfined

  var statusColor: Color {
    switch status {
    case .undedfined:
      return .primary
    case .notInWord:
      return .gray
    case .notInPosition:
      return .yellow
    case .inPosition:
      return .green
    }
  }
}
