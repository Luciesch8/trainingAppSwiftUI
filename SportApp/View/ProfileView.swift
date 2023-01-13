//
//  ProfileView.swift
//  SportApp
//
//  Created by Ah lucie nous gênes 🍄 on 11/01/2023.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Image("Memoji")
                        .resizable()
                        .frame(width: 130, height: 130) //Taille image
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .offset(x:130, y:30)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                
                VStack{
                    Text("Nom Prénom")
                        .font(.title)
                        .fontWeight(.bold)
                        .offset(x: 110, y:30)
                    
                    Text("Statistiques")
                        .font(.title)
                        .fontWeight(.bold)
                        .offset(x: 12, y:90)
                    
                    
                    Text("200")
                        .font(.title)
                        .fontWeight(.bold)
                        .offset(x: -5, y:130)
                    Text("Kilometre parcouru")
                        .font(.system(size:15))
                        .fontWeight(.light)
                        .offset(x: -5, y:130)
                    
                    Text("12")
                        .font(.title)
                        .fontWeight(.bold)
                        .offset(x: 115, y:79)
                    Text("Activités")
                        .font(.system(size:15))
                        .fontWeight(.light)
                        .offset(x: 115, y:79)
                    
                    Text("12")
                        .font(.title)
                        .fontWeight(.bold)
                        .offset(x: 230, y:27)
                    Text("Activités")
                        .font(.system(size:15))
                        .fontWeight(.light)
                        .offset(x: 230, y:27)
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }
            


        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
