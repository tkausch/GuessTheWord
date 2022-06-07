///
/// Copyright (c) 2022 Thomas Kausch
///
///
import SwiftUI

struct ContentView: View {
  
  @StateObject var game = WordlGame()

  var body: some View {
    VStack {
      Text("Wördle")
        .font(.largeTitle)
        .accessibilityAddTraits(.isHeader)
      Text("designed by Th. Kausch")
        .font(.caption)
      
      WordlGameView(wordlGame: game)
      KeyboardView(game: game)
        .padding(5)
      ActionBarView(
        game: game
      )
    }
    .frame(alignment: .top)
    .padding([.bottom], 10)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
