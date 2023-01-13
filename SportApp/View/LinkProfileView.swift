//
//  LinkProfileView.swift
//  SportApp
//
//  Created by Ah lucie nous gênes 🍄 on 11/01/2023.
//

import SwiftUI

func buttonPressed(){
    print("Button")
}

struct LinkProfileView: View {
    var body: some View {
        
        HStack{
            Image(systemName: "person.circle.fill")
                .resizable()
                .clipShape(Circle())
                .frame(width: 50, height: 50)
            
            
        }
        
    }

}
    



struct LinkProfileView_Previews: PreviewProvider {
    static var previews: some View {
        LinkProfileView()
    }
}
