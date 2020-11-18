//
//  NewView.swift
//  OpenWeatherDemo
//
//  Created by   admin on 18.11.2020.
//

import SwiftUI

//icon, temp, humidity, wind and description

struct DataView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        
        VStack {
            //
            if let image = viewModel.weather.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding()
            }
            
            Text("\(viewModel.weather.description)")
                .foregroundColor(.white)
            //
            Text("\(viewModel.weather.temp) C˚")
                .font(.system(size: 50))
                .foregroundColor(.white)
                .padding()
                    
            //
            HStack(spacing: 10) {
                Image("humidity")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                Text("\(viewModel.weather.humidity) %")
                    .foregroundColor(.white)
                    
            Spacer()
                Image("wind")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    
                Text("\(viewModel.weather.wind) m/s")
                    .foregroundColor(.white)
            }
            Text(colorScheme == .dark ? "In dark mode" : "In light mode")
                .foregroundColor(colorScheme == .dark ? .black : .white)
                .padding()
           // Spacer()
        }
        .padding()
        
    }
}

struct NewView_Previews: PreviewProvider {
    static var previews: some View {
        DataView().environmentObject(ViewModel())
    }
}
