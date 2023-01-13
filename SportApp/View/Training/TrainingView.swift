//
//  TrainingView.swift
//  SportApp
//
//  Created by Ah lucie nous gênes 🍄 on 11/01/2023.
//

import SwiftUI

struct TrainingView: View {
    var body: some View {
        
        NavigationView{
            VStack{
                NavigationLink(destination: RunView(), label: {Text("Course")
                    
                
                        
                })
                NavigationLink(destination: NewTrainingView(), label: {Text("Nouvelle entrainement")
                    
                })
                
                NavigationLink(destination: NotifListView(), label: {Text("Ajouer un rappel d'entrainement")
                    
                })
                
                .navigationTitle("Entrainement")
                
            }
        }
    }
}

struct TrainingView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingView()
    }
}
