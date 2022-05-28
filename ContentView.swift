//
//  ContentView.swift
//  Vascular
//
//  Created by Jason Fink on 5/27/22.
//  Copyright © 2022 Jason. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var wbcPosition = CGPoint(x:200, y:700)
    @State private var rbcPosition = CGPoint(x:200, y:450)
    
    @State var timer = Timer.publish(every: 0.12, on: .main, in: .common).autoconnect()
   
    var body: some View {
        
        GeometryReader { geo in
            
   //         ZStack {
                
                //RBC()
                
       //     }
                
            RBC()   .position(self.rbcPosition)
            .onReceive(self.timer) {_ in
                self.rbcMove()
                }
            WBC()     .onReceive(self.timer) {_ in
                      self.gravity()
              }
            .frame(width: geo.size.width, height: geo.size.height)
            .position(self.wbcPosition)
            .background(Color(#colorLiteral(red: 0.3525061763, green: 0, blue: 0, alpha: 0.9)))
        }
            .edgesIgnoringSafeArea(.all)
    }
    func gravity() {
        withAnimation{
        self.wbcPosition.y += -10
        self.rbcPosition.y += 10
        }
    }
    
    func rbcMove() {
        if self.rbcPosition.y > 0
        {
            withAnimation{
                self.rbcPosition.y -= -10
            }
        }
        else
        {
        self.rbcPosition.y = 1000
            self.rbcPosition.y = CGFloat.random(in: 0...500)
        }
    }
}


