//
//  NewTrainingView.swift
//  SportApp
//
//  Created by Ah lucie nous gênes 🍄 on 13/01/2023.
//

import SwiftUI


struct NewTrainingView: View {
    
    //Select Sport
    @State private var sportIndex = 0



    var sports = ["Vélo", "Tennis", "Football", "Basketball"]
    var body: some View {
        Form{
            Section{
                Picker(selection: $sportIndex, label: Text("Choisissez un sport")){
                    ForEach(0 ..< sports.count){
                        Text(self.sports[$0]).tag($0)
                    }
                }
                
                Picker(selection: $sportIndex, label: Text("Choisissez un sport")){
                    ForEach(0 ..< sports.count){
                        Text(self.sports[$0]).tag($0)
                    }
                }

            }
        }
        .navigationBarTitle(Text("Nouvelle Activité"))
    }
}


struct NewTrainingView_Previews: PreviewProvider {
    static var previews: some View {
        NewTrainingView()
    }
}
