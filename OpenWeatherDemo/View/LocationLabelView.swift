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
    var body: some View {
        
        VStack{
            HStack {
                Text("\(viewModel.weather.name ?? "")")
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .font(.title2)
                    .padding()
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
