///
/// Copyright (c) 2022 Thomas Kausch
///
///
import SwiftUI

struct ContentView: View {
  
  @StateObject var game = WordlGame()
  
  var body: some View {
    VStack {
      TitleView()
      WordlGameView(wordlGame: game)
        .background(Color.init(UIColor.white))
      KeyboardView(game: game)
        .padding(10)
      ActionBarView(
        game: game
      )
    }
    .frame(alignment: .top)
    .padding([.bottom], 10)
    .background(.bar)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
