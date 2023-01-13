//
//  HomeView.swift
//  SportApp
//
//  Created by Ah lucie nous gênes 🍄 on 11/01/2023.
//

import SwiftUI

struct HomeView: View{
    var body: some View {
        NavigationView{
            ZStack{
                Text("Home Test")
            }
            .navigationTitle("Home")
        }
    }

}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
