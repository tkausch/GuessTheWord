///
/// Copyright (c) 2022 Thomas Kausch
///
///
import SwiftUI

struct LetterBoxView: View {
  var size: Double

  var body: some View {
    RoundedRectangle(cornerRadius: size / 5.0)
      .stroke(Color(UIColor.label))
      .frame(width: size, height: size)
  }
}

struct LetterBox_Previews: PreviewProvider {
  static var previews: some View {
    LetterBoxView(size: 50.0)
  }
}
