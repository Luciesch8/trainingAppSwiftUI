//
//  ContentView.swift
//  SportApp
//
//  Created by Ah lucie nous gênes 🍄 on 11/01/2023.
//

import SwiftUI
import Alamofire




struct ContentView: View {
    var body: some View {
        // Config de la table View
        TabView{
            
            HomeView()
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
            
            TrainingView()
                .tabItem{
                    Image(systemName: "figure.highintensity.intervaltraining")
                    Text("Entraînement")
                }
            
            ActivityView()
                .tabItem{
                    Image(systemName: "chart.xyaxis.line")
                    Text("Activité")
                }
            
            ProgramView()
                .tabItem{
                    Image(systemName: "list.clipboard")
                    Text("Programme")
                }
        }

        
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
