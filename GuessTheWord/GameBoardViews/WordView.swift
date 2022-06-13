///
/// Copyright (c) 2022 Thomas Kausch
///
///
import SwiftUI

struct WordView: View {
  
  @Binding var word: Word
  
  var length: Int

  var unguessedLetters: Int {
    length - word.letters.count
  }

  var body: some View {
    GeometryReader { proxy in
      HStack {
        Spacer()
        let width = (proxy.size.width - 40) / CGFloat(length) * 0.8
        // Draw already guess letters
        ForEach(word.letters.indices, id: \.self) { index in
          let letter = word.letters[index]
          LetterView(letter: letter, size: width, index: index)
        }
        // Draw empty input boxes
        ForEach(0..<unguessedLetters, id: \.self) { _ in
          LetterBoxView(size: width)
        }
        Spacer()
      }
      .padding(5.0)
      .overlay(
        Group {
          if word.status == .invalidWord {
            Text("Word not in dictionary.")
              .foregroundColor(.red)
              .fontWeight(.bold)
              .background(Color(UIColor.systemBackground).opacity(0.9))
              .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                  word.status = .pending
                }
              }
          }
        }
      )
    }
  }
}

struct WordView_Previews: PreviewProvider {
  static var previews: some View {
    let guessedLetter = Letter(letter: "S", status: .inPosition)
    let guessedLetter2 = Letter(letter: "A", status: .notInPosition)
    let guess = Word(
      letters: [guessedLetter, guessedLetter2],
      status: .pending
    )
    WordView(
      word: .constant(guess),
      length: 5
    )
  }
}
