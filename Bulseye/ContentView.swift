//
//  ContentView.swift
//  Bulseye
//
//  Created by Peter Kovacs on 2020. 07. 01..
//  Copyright © 2020. Wallise. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible: Bool = false
    @State var whosThereIsVisible: Bool = false
    
    var body: some View {
        VStack {
            Text("Welcome to my first app!")
                .fontWeight(.bold)
                .foregroundColor(Color.green)
            Button(action: {
                print("Button pressed!")
                self.alertIsVisible = true
            }) {
                Text(/*@START_MENU_TOKEN@*/"Hit Me!"/*@END_MENU_TOKEN@*/)
            }
            .alert(isPresented: $alertIsVisible){() ->
                Alert in
                return Alert(title: Text("Hello There"),
                             message: Text("This is my first pop-up"),
                             dismissButton: .default(Text("Awesome")))
            }
            Button(action: {
                self.whosThereIsVisible = true
            }) {
                Text(/*@START_MENU_TOKEN@*/"Knock, Knock!"/*@END_MENU_TOKEN@*/)
            }
            .alert(isPresented: $whosThereIsVisible){ () ->
                Alert in
                return Alert(title: Text("Who's there"),
                             dismissButton: .default(Text("Me :(")))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
