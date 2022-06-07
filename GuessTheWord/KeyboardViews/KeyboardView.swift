///
/// Copyright (c) 2022 Thomas Kausch
///
///

import SwiftUI

struct KeyboardView: View {
  
  @ObservedObject var game: WordlGame
  
  let keyboard = "QWERTZUIOPÜ|ASDFGHJKLÖÄ|<YXCVBNM>"

  var body: some View {
    let lines = keyboard.split(separator: "|")
    VStack {
      ForEach(lines, id: \.self) { line in
        HStack {
          let keyArray = line.map { String($0) }
          ForEach(keyArray, id: \.self) { key in
            KeyButtonView(game: game, key: key)
          }
        }
      }
    }
  }
}

struct KeyboardView_Previews: PreviewProvider {
  static var previews: some View {
    KeyboardView(game: WordlGame()).padding()
  }
}
