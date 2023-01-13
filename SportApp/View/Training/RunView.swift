//
//  RunView.swift
//  SportApp
//
//  Created by Ah lucie nous gênes 🍄 on 12/01/2023.
//

import SwiftUI
import MapKit

struct RunView: View {
    

    var body: some View {

        NavigationView{
            VStack{
                GeometryReader{ proxy in MapsView()
                        .padding(0)
                        .frame(height: 500)
                }
                

            }
        }.navigationTitle("Course")
        

    }
}

struct RunView_Previews: PreviewProvider {
    static var previews: some View {
        RunView()
    }
}
