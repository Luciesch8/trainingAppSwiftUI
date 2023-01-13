//
//  ProgramView.swift
//  SportApp
//
//  Created by Ah lucie nous gênes 🍄 on 11/01/2023.
//

import SwiftUI

struct ProgramView: View {
    @State var currentTab: Int = 0
    var body: some View {
        NavigationView{


        ZStack(alignment: .top) {
            TabView(selection: self.$currentTab) {
                // Config de la table View
                ForYouView().tag(0)
                
                ActivityProgView().tag(1)
                MealView().tag(2)
            }

            .tabViewStyle(.page(indexDisplayMode: .never))
            .edgesIgnoringSafeArea(.all)
            
            TabBarView(currentTab: self.$currentTab)

            }
        .navigationTitle("Programme")
       }
    }
}


// Config de Tab Bar
struct TabBarView: View {
    @Binding var currentTab: Int
    @Namespace var namespace
    
    var tabBarOptions: [String] = ["Pour vous", "Activité", "Repas"]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 75) {
                ForEach(Array(zip(self.tabBarOptions.indices,
                                  self.tabBarOptions)),
                        id: \.0,
                        content: {
                    index, name in
                    TabBarItem(currentTab: self.$currentTab,
                               namespace: namespace.self,
                               tabBarItemName: name,
                               tab: index)
                    
                })
            }
            
            .padding(.horizontal)
        }
        .background(Color.white)
        .frame(height: 230)
        .edgesIgnoringSafeArea(.all)
    }
}

//Config de l'Item de la Tab Bar
struct TabBarItem: View {
    @Binding var currentTab: Int
    let namespace: Namespace.ID
    
    var tabBarItemName: String
    var tab: Int
    
    var body: some View {
        Button {
            self.currentTab = tab
        } label: {
            VStack {
                Spacer()
                Text(tabBarItemName)
                if currentTab == tab {
                    Color.black
                        .frame(height: 2)
                        .matchedGeometryEffect(id: "underline",
                                               in: namespace,
                                               properties: .frame)
                } else {
                    Color.clear.frame(height: 2)
                }
            }

            .animation(.spring(), value: self.currentTab)

        }
        .buttonStyle(.plain)
    }
}

struct ProgramView_Previews: PreviewProvider {
    static var previews: some View {
        ProgramView()
    }
}
