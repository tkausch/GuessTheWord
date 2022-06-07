///
/// Copyright (c) 2022 Thomas Kausch
///
///
import Foundation
import SwiftUI

enum WordlGameStatus {
  case initializing
  case new
  case inprogress
  case won
  case lost
}

class WordlGame: ObservableObject {
  
  let wordLength = 5
  let maxGuesses = 6
  
  var dictionary: WordlDictionary
  var status: WordlGameStatus = .initializing

  @Published var targetWord: String
  @Published var currentGuess = 0
  
  @Published var words: [Word]

  init() {
    
    // Load dictionary of words with fixed length
    dictionary = WordlDictionary(length: wordLength)
    
    // Get a random word from dictionary
    let totalWords = dictionary.commonWords.count
    let randomWord = Int.random(in: 0..<totalWords)
    let word = dictionary.commonWords[randomWord]
    
    // This word needs to be guessed
    targetWord = word
    #if DEBUG
    print("selected word: \(word)")
    #endif
    
    // initialize the wordl with empty word guess list
    words = .init()
    
    // append first guess
    words.append(Word())
    status = .new
  }

  func addLetter(_ letter: String) {
    if status == .new {
      status = .inprogress
    }
    
    guard status == .inprogress else {
      return
    }

    switch letter {
    case "<":
      deleteLetter()
    case ">":
      checkGuess()
    default:
      if words[currentGuess].letters.count < wordLength {
        let newLetter = Letter(letter: letter)
        words[currentGuess].letters.append(newLetter)
      }
    }
  }

  func deleteLetter() {
    let currentLetters = words[currentGuess].letters.count
    guard currentLetters > 0 else { return }
    words[currentGuess].letters.remove(at: currentLetters - 1)
  }

  func checkGuess() {
    
    guard words[currentGuess].letters.count == wordLength  else { return }
    
    if !dictionary.isValidWord(words[currentGuess].text) {
      words[currentGuess].status = .invalidWord
      return
    }

    words[currentGuess].status = .complete

    var targetLettersRemaining = Array(targetWord)
  
    for index in words[currentGuess].letters.indices {
      let stringIndex = targetWord.index(targetWord.startIndex, offsetBy: index)
      let letterAtIndex = String(targetWord[stringIndex])
      
      if letterAtIndex == words[currentGuess].letters[index].letter {
      
        words[currentGuess].letters[index].status = .inPosition
      
        if let letterIndex =
          targetLettersRemaining.firstIndex(of: Character(letterAtIndex)) {
          targetLettersRemaining.remove(at: letterIndex)
        }
      }
    }

    // 1
    for index in words[currentGuess].letters.indices
      .filter({ words[currentGuess].letters[$0].status == .undedfined }) {
      // 2
      let letterAtIndex = words[currentGuess].letters[index].letter
      // 3
      var letterStatus = LetterStatus.notInWord
      // 4
      if targetWord.contains(letterAtIndex) {
        // 5
        if let guessedLetterIndex =
          targetLettersRemaining.firstIndex(of: Character(letterAtIndex)) {
          letterStatus = .notInPosition
          targetLettersRemaining.remove(at: guessedLetterIndex)
        }
      }
      // 6
      words[currentGuess].letters[index].status = letterStatus
    }

    if targetWord == words[currentGuess].text {
      status = .won
      return
    }

    if currentGuess < maxGuesses - 1 {
      words.append(Word())
      currentGuess += 1
    } else {
      status = .lost
    }
  }

  func newGame() {
    let totalWords = dictionary.commonWords.count
    let randomWord = Int.random(in: 0..<totalWords)
    targetWord = dictionary.commonWords[randomWord]
    print("Selected word: \(targetWord)")

    currentGuess = 0
    words = []
    words.append(Word())
    status = .new
  }
}

extension WordlGame {
  convenience init(word: String) {
    self.init()
    self.targetWord = word
  }

  static func inProgressGame() -> WordlGame {
    let wordl = WordlGame(word: "SMILE")
    wordl.addLetter("S")
    wordl.addLetter("T")
    wordl.addLetter("O")
    wordl.addLetter("L")
    wordl.addLetter("E")
    wordl.addLetter(">")
    
    wordl.addLetter("M")
    wordl.addLetter("I")
    wordl.addLetter("L")
    wordl.addLetter("E")
    wordl.addLetter("S")
    wordl.addLetter(">")
    
    wordl.addLetter("S")
    return wordl
  }

  static func wonGame() -> WordlGame {
    let wordl = WordlGame(word: "SMILE")
    wordl.addLetter("S")
    wordl.addLetter("T")
    wordl.addLetter("O")
    wordl.addLetter("L")
    wordl.addLetter("E")
    wordl.addLetter(">")

    wordl.addLetter("M")
    wordl.addLetter("I")
    wordl.addLetter("L")
    wordl.addLetter("E")
    wordl.addLetter("S")
    wordl.addLetter(">")

    wordl.addLetter("S")
    wordl.addLetter("M")
    wordl.addLetter("I")
    wordl.addLetter("L")
    wordl.addLetter("E")
    wordl.addLetter(">")

    return wordl
  }

  static func lostGame() -> WordlGame {
    let wordl = WordlGame(word: "SMILE")

    wordl.addLetter("P")
    wordl.addLetter("I")
    wordl.addLetter("A")
    wordl.addLetter("N")
    wordl.addLetter("O")
    wordl.addLetter(">")

    wordl.addLetter("S")
    wordl.addLetter("T")
    wordl.addLetter("O")
    wordl.addLetter("L")
    wordl.addLetter("E")
    wordl.addLetter(">")

    wordl.addLetter("S")
    wordl.addLetter("P")
    wordl.addLetter("O")
    wordl.addLetter("I")
    wordl.addLetter("L")
    wordl.addLetter(">")

    wordl.addLetter("S")
    wordl.addLetter("T")
    wordl.addLetter("A")
    wordl.addLetter("R")
    wordl.addLetter("E")
    wordl.addLetter(">")

    wordl.addLetter("M")
    wordl.addLetter("I")
    wordl.addLetter("L")
    wordl.addLetter("E")
    wordl.addLetter("S")
    wordl.addLetter(">")

    wordl.addLetter("S")
    wordl.addLetter("M")
    wordl.addLetter("E")
    wordl.addLetter("L")
    wordl.addLetter("L")
    wordl.addLetter(">")

    return wordl
  }

  static func complexGame() -> WordlGame {
    let wordl = WordlGame(word: "THEME")

    wordl.addLetter(  "E")
    wordl.addLetter(  "E")
    wordl.addLetter(  "R")
    wordl.addLetter(  "I")
    wordl.addLetter(  "E")
    wordl.addLetter(  ">")

    wordl.addLetter(  "S")
    wordl.addLetter(  "T")
    wordl.addLetter(  "E")
    wordl.addLetter(  "E")
    wordl.addLetter(  "L")
    wordl.addLetter(  ">")

    wordl.addLetter(  "T")
    wordl.addLetter(  "H")
    wordl.addLetter(  "E")
    wordl.addLetter(  "M")
    wordl.addLetter(  "E")
    wordl.addLetter(  ">")

    return wordl
  }
}
