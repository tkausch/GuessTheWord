///
/// Copyright (c) 2022 Thomas Kausch
///
///
import SwiftUI

struct WordlGameView: View {
  
  @ObservedObject var wordlGame: WordlGame

  var remainingGuesses: Int {
    let remainingGuesses = wordlGame.maxGuesses - wordlGame.words.count
    if remainingGuesses < 0 {
      return 0
    }
    return remainingGuesses
  }

  var body: some View {
    VStack {
      ForEach($wordlGame.words) { guess in
        WordView(word: guess, length: wordlGame.wordLength)
      }
      ForEach(0..<remainingGuesses, id: \.self) { _ in
        WordView(word: .constant(Word()), length: wordlGame.wordLength)
      }
    }
    .padding(10)
  }
}

struct WordlView_Previews: PreviewProvider {
  static var previews: some View {
    WordlGameView(wordlGame: WordlGame.inProgressGame())
  }
}
