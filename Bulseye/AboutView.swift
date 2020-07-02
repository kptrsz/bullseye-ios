//
//  AboutView.swift
//  Bulseye
//
//  Created by Peter Kovacs on 2020. 07. 01..
//  Copyright © 2020. Wallise. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    struct HeaderStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 30))
                .padding(.top, 20)
                .padding(.bottom, 20)
        }
    }
    
    struct TextStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 16))
                .padding(.bottom, 20)
                .padding(.leading, 60)
                .padding(.trailing, 60)
            
            
        }
    }
    
    var body: some View {
        Group{
            VStack {
                Text("🎯 Bullseye 🎯")
                    .modifier(HeaderStyle())
                Text("This is Bullseye, the game where you canwin points and earn fame by dragging a slider.").modifier(TextStyle())
                Text("Your goal is to place the slider as close s possible to the rget value. The closer you are, the more point you score!").modifier(TextStyle())
                Text("Enjoy!").modifier(TextStyle())
            }
            .background(Color(red:255.0/255.0, green: 214.0/255.0,blue: 179.0/255.0))
            .navigationBarTitle("About Bullseye")
        }
        .background(Image("Background"))
    }}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
