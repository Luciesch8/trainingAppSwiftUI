//
//  ActivityView.swift
//  SportApp
//
//  Created by Ah lucie nous gênes 🍄 on 11/01/2023.
//

import SwiftUI
import Charts

struct ActivityView: View {
    //MARK: State Chart Data For Animation Changes
    @State var sampleAnalytics: [ChartModel] = sample_analytics
    //MARK: State View Proprieties
    @State var currentTab: String = "7 Days"
    //MARK: Gesture Properties
    @State var currentActiveItem : ChartModel?
    @State var plotWidth: CGFloat = 0
    
    @State var isLineGraph: Bool = false
    var body: some View {
            NavigationView{
                VStack{
                    
                    VStack(alignment: .leading, spacing: 12){
                        HStack{
                            Text("Views")
                                .fontWeight(.semibold)
                            
                            Picker("", selection: $currentTab){
                                Text("7 Days")
                                    .tag("7 Days")
                                Text("Week")
                                    .tag("Week")
                                Text("Month")
                                    .tag("Month")
                            }
                            .pickerStyle(.segmented)
                            .padding(.leading,80)
                        }
                        
                        let totalValue = sampleAnalytics.reduce(0.0) { partialResult, item in
                            item.views + partialResult
                        }
                        
                        Text(totalValue.stringFormat)
                            .font(.largeTitle.bold())
                        
                        AnimatedChart()

                    }
                    .padding()
                    .background{
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.white.shadow(.drop(radius: 2)))
                    }
                    
                    Toggle("Line Graph", isOn: $isLineGraph)
                        .padding(.top)
                    
                    
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding()
                .navigationTitle("Activité")
                
                //MARK: Simply Updating Values For Segmented Tabs
                .onChange(of: currentTab) { newValue in
                    sampleAnalytics = sample_analytics
                    if newValue != "7 Days" {
                        for(index,_) in sampleAnalytics.enumerated(){
                            sampleAnalytics[index].views = .random(in: 1500...10000)
                        }
                    }
                    
                    //Re-Animating View
                    animateGraph(fromChange: true)
                }

            }
        
        
        }
    
    @ViewBuilder
    func AnimatedChart()->some View{
        
        let max = sampleAnalytics.max{ item1, item2 in
            return item2.views > item1.views
        }?.views ?? 0
        
        Chart{
            ForEach(sampleAnalytics){ item in
                //MARK: Bar Graph
                //MARK: Animating Graph
                if isLineGraph{
                    LineMark(x: .value("Hours", item.hours,unit: .hour),
                            y: .value("Views",item.animated ? item.views : 0)
                    )
                    
                    //Gradient Style
                    .interpolationMethod(.catmullRom)

                    
                }else{
                    BarMark(x: .value("Hours", item.hours,unit: .hour),
                            y: .value("Views",item.animated ? item.views : 0)
                    )
                    
                    //Gradient Style
                    .interpolationMethod(.catmullRom)
                }
                
                if isLineGraph{
                    AreaMark(x: .value("Hours", item.hours,unit: .hour),
                            y: .value("Views",item.animated ? item.views : 0)
                    )
                    
                    //Gradient Style
                    .interpolationMethod(.catmullRom)

                }
                
                //MARK: Rule Mark For Currently Dragging Item
                if let currentActiveItem,currentActiveItem.id == item.id {
                    RuleMark(x: .value("Hour", currentActiveItem.hours))
                    //Dotted Style
                        .lineStyle(.init(lineWidth: 2, miterLimit: 2, dash: [2], dashPhase: 5))
                    //MARK: Setting In Middle Of Each Bars
                        .offset(x: (plotWidth / CGFloat(sampleAnalytics.count)) / 2 )
                        .annotation(position: .top){
                            VStack(alignment: .leading, spacing: 6){
                                Text("Views")
                                    .font(.caption)
                                
                                Text(currentActiveItem.views.stringFormat)
                                    .font(.title3.bold())
                                
                            }
                            .padding(.horizontal,10)
                            .padding(.vertical,4)
                            .background{
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .fill(.white.shadow(.drop(radius: 2)))
                                
                            }
                        }
                }
            }
        }
        //MARK: Cust Y-Axis
        .chartYScale(domain: 0...(max + 5000))
        //MARK: HighLight Current Bar
        .chartOverlay(content: { proxy in
            GeometryReader{innerProxy in
                Rectangle()
                    .fill(.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .onEnded{value in
                                //MARK: Getting Current Location
                                let location = value.location
                                
                                if let date: Date = proxy.value(atX: location .x){
                                    
                                    let calendar = Calendar.current
                                    let hour = calendar.component(.hour, from: date)
                                    
                                    if let currentItem = sampleAnalytics.first(where: { item in
                                        calendar.component(.hour, from: item.hours) == hour
                                    })
                                    {
                                        self.currentActiveItem = currentItem
                                        self.plotWidth = proxy.plotAreaSize.width
                                    }
                                }
                                
                            }
                            .onEnded{value in
                                self.currentActiveItem = nil
                            }
                    )
                
            }
            
        })

        .frame(height: 250)
        .onAppear{
            animateGraph()
        }
    }
    
    //MARK: Animating Graph
    func animateGraph(fromChange: Bool = false){
        for (index,_) in sampleAnalytics.enumerated(){
            // Using Dispatch Queue Delay
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * (fromChange ? 0.03 : 0.05)){
                withAnimation(fromChange ? .easeInOut(duration: 0.8) : .interactiveSpring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.8)){
                    sampleAnalytics[index].animated = true
                }
            }
        }
    }
}



struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}


//MARK: Extention To Convert Double To String With K,M Number Values

extension Double{
    var stringFormat : String {
        if self >= 10000 && self < 99999{
            return String(format: "%.1fK", self / 1000).replacingOccurrences(of: ".0", with: "")
        }
        
        if self > 99999{
            return String(format: "%.1fM", self / 100000).replacingOccurrences(of: ".0", with: "")
        }
        
        return String(format: "%.0f", self)

            
    }
}
