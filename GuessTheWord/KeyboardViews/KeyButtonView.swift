///
/// Copyright (c) 2022 Thomas Kausch
///
///

import SwiftUI

struct KeyButtonView: View {
  
  // each button knows its game and observs it
  @ObservedObject var game: WordlGame
  
  var key: String

  var body: some View {
    Button {
      game.addLetter(key)
    } label: {
      switch key {
      case "<":
        Image(systemName: "delete.backward")
      case ">":
        Image(systemName: "return")
      default:
        Text(key)
          .aspectRatio(1.0, contentMode: .fit)
          .frame(maxWidth: .infinity)
      }
    }
    .padding(6)
    .background {
      RoundedRectangle(cornerRadius: 5.0)
        .stroke()
    }
    .foregroundColor(Color(UIColor.label))
  }
}

struct KeyButtonView_Previews: PreviewProvider {
  static var previews: some View {
    let game = WordlGame()
    Group {
      KeyButtonView(game: game, key: ">")
    }
  }
}
