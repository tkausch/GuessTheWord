///
/// Copyright (c) 2022 Thomas Kausch
///
///
import SwiftUI

struct ActionBarView: View {
  
  @ObservedObject var game: WordlGame

  var body: some View {
    HStack {
      Spacer()
      Button {
        game.newGame()
      } label: {
        Image(systemName: "restart.circle")
          .imageScale(.large)
          .accessibilityLabel("New Game")
      }
      .disabled(game.status == .inprogress || game.status == .new)
    }.padding(7)
  }
}

struct ActionBarView_Previews: PreviewProvider {
  static var previews: some View {
    ActionBarView(
      game: WordlGame.wonGame()
    )
  }
}
