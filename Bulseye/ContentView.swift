//
//  ContentView.swift
//  Bulseye
//
//  Created by Peter Kovacs on 2020. 07. 01..
//  Copyright © 2020. Wallise. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var startOverAlertIsVisisble = false
    
    @State var sliderValue  = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var roundCount = 1
    
    var midnightBlue = Color(red:0.0/255.0, green: 51.0/255.0,blue: 102.0/255.0)
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(Color.white)
                .modifier(ShadowStyle())
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 12))
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .modifier(ShadowStyle())                .foregroundColor(Color.yellow)
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
        }
    }
    
    struct ShadowStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .shadow(color: Color.black, radius:10)
        }
    }
    
    var body: some View {
        
        VStack {
            // Target row
            VStack {
                Spacer()
                HStack {
                    Text("Put the bullseye as close as close you can to:").modifier(LabelStyle())
                    Text("\(target)").modifier(ValueStyle())
                }
                Spacer()
                HStack {
                    Text("1").modifier(LabelStyle())
                    Slider(value: $sliderValue, in: 1...100).accentColor(Color.green)
                    Text("100").modifier(LabelStyle())
                }
                Spacer()
                
                // Button row
                Button(action: {
                    self.alertIsVisible = true
                }) {
                    Text(/*@START_MENU_TOKEN@*/"Hit Me!"/*@END_MENU_TOKEN@*/).modifier(ButtonLargeTextStyle())
                }
                .alert(isPresented: $alertIsVisible){() ->
                    Alert in
                    let roundedValue = Int(sliderValue.rounded())
                    return Alert(title: Text("\(alertTitle())"),
                                 message: Text("The slider's value is \(roundedValue). \n You scored \(pointsForCurrentRound()) points this round"),
                                 dismissButton: .default(Text("Awesome")) {
                                    self.score = self.score + self.pointsForCurrentRound()
                                    self.roundCount += 1
                                    self.target = Int.random(in: 1...100)
                        })
                }.background(Image("Button")).modifier(ShadowStyle())
                
                Spacer()
            }
            
            // Score row
            HStack {
                Button(action: {
                    self.startOverAlertIsVisisble = true
                }){
                    HStack {
                        Image("StartOverIcon")
                        Text("Start over").modifier(ButtonSmallTextStyle())
                    }
                }.alert(isPresented: $startOverAlertIsVisisble) { () ->
                    Alert in
                    return Alert(title: Text("Are you sure?"),
                                 primaryButton: .default(Text("Yes")) {
                                    self.resetGame()
                        }, secondaryButton: .default(Text("Cancel"))
                    )
                }.disabled(roundCount == 1)
                    .background(Image("Button")).modifier(ShadowStyle())
                Spacer()
                Text("Score:").modifier(LabelStyle())
                Text("\(score)").modifier(ValueStyle())
                Spacer()
                Text("Round").modifier(LabelStyle())
                Text("\(roundCount)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: AboutView()){
                    HStack{
                        Image("InfoIcon")
                        Text("Info").modifier(ButtonSmallTextStyle())}
                }
                .background(Image("Button")).modifier(ShadowStyle())
            }.padding(.bottom, 20)
        }
        .background(Image("Background"), alignment: .center)
        .accentColor(midnightBlue)
    .navigationBarTitle("Bullseye")
    }
    
    func resetGame(){
        sliderValue  = 50.0
        target = Int.random(in: 1...100)
        score = 0
        roundCount = 1
    }
    
    func amountOff() -> Int {
        return abs(Int(sliderValue.rounded()) - Int(target))
    }
    
    func bonusPoints() -> Int {
        if amountOff() == 0 {
            return 100
        }else if amountOff() <= 3 {
            return 50
        } else{
            return 0
        }
    }
    
    func pointsForCurrentRound() -> Int{
        return 100 - amountOff() + bonusPoints()
    }
    
    func alertTitle() -> String{
        let diff = abs(amountOff())
        let title:String
        
        if diff == 0{
            title = "Perfect!"
        }else if diff < 5{
            title = "You almost had it!"
        }else if diff <= 10{
            title = "Not bad!"
        } else {
            title = "Not even close"
        }
        return title
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
