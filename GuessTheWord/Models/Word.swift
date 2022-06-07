///
/// Copyright (c) 2022 Thomas Kausch
///
///
import Foundation

enum WordStatus {
  case pending
  case complete
  case invalidWord
}

struct Word: Identifiable {
  var id = UUID()
  var letters: [Letter] = []
  var status: WordStatus = .pending

  var text: String {
    return letters.reduce("") { result, next in
      result.appending(next.letter)
    }
  }
}
