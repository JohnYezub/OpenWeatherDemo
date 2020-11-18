//
//  ContentView.swift
//  OpenWeatherDemo
//
//  Created by   admin on 18.11.2020.
//

import SwiftUI

//main view

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        ZStack {            
            BackView()                
            LocationLabelView()
            DataView()
               .offset(y: -20)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ViewModel())
    }
}
