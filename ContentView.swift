//
//  ContentView.swift
//  VascularGame
//
//  Created by Jason Fink on 6/1/22.
//  Copyright © 2022 Jason. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var wbcPosition = CGPoint(x: 200, y: 700)
    @State private var obstPosition = CGPoint(x: 200, y: 100)
    
    @State var timer = Timer.publish(every: 0.08, on: .main, in: .common).autoconnect()

    var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
                        Pixel(size: 50, color: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                            .position(self.wbcPosition)
                            .onReceive(self.timer) {_ in
                                self.gravity()
                            }
                
                        Obstacle()
                            .position(self.obstPosition)
                            .onReceive(self.timer) {_ in
                                self.obstMove()
                            }
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .background(Color(#colorLiteral(red: 0.3525061763, green: 0, blue: 0, alpha: 0.9)))
        .gesture(
            TapGesture()
                .onEnded {
                    withAnimation {
                    self.wbcPosition.x -= 100
                    }
                })
                .onReceive(self.timer) {_ in self.collision()}
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func gravity() {
        withAnimation {
        self.wbcPosition.x += 20
        }
    }
    
    func obstMove() {
        if self.obstPosition.y > 1000 {
            self.obstPosition.y = 100
        }
        else
        {
            withAnimation {
                 self.obstPosition.y += 40
            }
        }
        }
    
    func pause() {
        self.timer.upstream.connect().cancel()
    }
    
    func resume() {
        self.timer = Timer.publish(every: 0.08, on: .main, in: .common).autoconnect()
    }
    
    func collision() {
        if abs(wbcPosition.y - obstPosition.y) < (25 + 20) && abs(wbcPosition.x - obstPosition.x) < (25 + 20) {
            self.pause()
        }
    }
}
