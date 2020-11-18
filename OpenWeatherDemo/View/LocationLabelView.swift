//
//  LocationView.swift
//  OpenWeatherDemo
//
//  Created by   admin on 18.11.2020.
//

import SwiftUI

//View for location name label
struct LocationLabelView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        
        VStack{
            HStack {
                Text("\(viewModel.weather.name ?? "--"), \(viewModel.weather.country ?? "-")")
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .font(.title2)
                    .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .padding(.top, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Text("")
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .font(.title2)
                
                Spacer()
            }
            Spacer()
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationLabelView().environmentObject(ViewModel())
    }
}
