//
//  ContentView.swift
//  VascularGame
//
//  Created by Jason Fink on 6/1/22.
//  Copyright © 2022 Jason. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var wbcPosition = CGPoint(x: 100, y: 100) //200, 700
    @State private var obstPosition = CGPoint(x: 700, y: 200)
    @State private var isPaused = false
    
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
                
                self.isPaused ? Button("Restart") {self.resume()} : nil
                
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .background(Color(#colorLiteral(red: 0.3525061763, green: 0, blue: 0, alpha: 0.9)))
        .gesture(
            TapGesture()
                .onEnded {
                    withAnimation {
                    self.wbcPosition.y -= 100
                    }
                })
                .onReceive(self.timer) {_ in self.collision()}
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func gravity() {
        withAnimation {
        self.wbcPosition.y += 20
        }
    }
    
    func obstMove() {
        if self.obstPosition.x < 0 {
            self.obstPosition.x = 1000
        }
        else
        {
            withAnimation {
                 self.obstPosition.x -= 40
            }
        }
        }
    
    func pause() {
        self.timer.upstream.connect().cancel()
    }
    
    func resume() {
        self.timer = Timer.publish(every: 0.08, on: .main, in: .common).autoconnect()
        
        self.obstPosition.x = 1000 // Move obstacle to starting position
        self.wbcPosition = CGPoint(x: 100, y: 100)
    }
    
    func collision() {
        if abs(wbcPosition.y - obstPosition.y) < (20 + 15) && abs(wbcPosition.x - obstPosition.x) < (20 + 15) {
            self.pause()
            self.isPaused = true
        }
    }
}
