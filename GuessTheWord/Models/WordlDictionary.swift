///
/// Copyright (c) 2022 Thomas Kausch
///
///
import Foundation

class WordlDictionary: ObservableObject {
  
  var wordLength: Int
  
  @Published var commonWords: [String] = []

  init(length: Int) {
    wordLength = length
    
    guard
      let commonFileUrl = Bundle.main.url(forResource: "common-words-5", withExtension: "txt"),
      let commonDictionary = try? String(contentsOf: commonFileUrl, encoding: .utf8) else {
        return
      }

    for word in commonDictionary.split(separator: "\n") {
      let newWord = String(word)
      if newWord.count == wordLength {
        commonWords.append(newWord.uppercased())
      }
    }
  }

  func isValidWord(_ word: String) -> Bool {
    let casedWord = word.uppercased()
    return commonWords.contains { $0 == casedWord }
  }
}
