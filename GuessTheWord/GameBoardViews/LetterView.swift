/// Copyright (c) 2022 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// Copyright (c) 2022 Thomas Kausch
///
///
import SwiftUI

struct LetterView: View {
  
  var letter: Letter
  
  var size: Double
  var index: Int

  var body: some View {
    Text(letter.letter)
      .font(.title)
      .foregroundColor(Color(UIColor.systemBackground))
      .frame(width: size, height: size)
      .background(letter.statusColor)
      .cornerRadius(size / 5.0)
  }
}

struct GuessBoxView_Previews: PreviewProvider {
  static var previews: some View {
    let guess = Letter(letter: "S", status: .inPosition)
    LetterView(letter: guess, size: 50, index: 1)
  }
}
