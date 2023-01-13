//
//  MapsView.swift
//  SportApp
//
//  Created by Ah lucie nous gênes 🍄 on 12/01/2023.
//

import SwiftUI
import MapKit

struct MapsView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region)
            .accentColor(Color(.systemPink))
            .onAppear{
                viewModel.checkIfLocationServiceIsEnabled()
            }
    }
}

struct MapsView_Previews: PreviewProvider {
    static var previews: some View {
        MapsView()
        
    }
}
