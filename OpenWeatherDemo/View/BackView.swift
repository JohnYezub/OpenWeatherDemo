//
//  BackView.swift
//  OpenWeatherDemo
//
//  Created by   admin on 18.11.2020.
//

import SwiftUI

//background view
struct BackView: View {
    var body: some View {
        GeometryReader { geometry in
        Image("back3")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
            .frame(maxWidth: geometry.size.width,
                                       maxHeight: geometry.size.height)
        }
    }
}

struct BackView_Previews: PreviewProvider {
    static var previews: some View {
        BackView()
    }
}
