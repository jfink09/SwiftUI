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
    @State private var ceilingPosition = CGPoint(x:0, y:10)
    @State private var floorPosition = CGPoint(x:0, y:405)
    @State private var isPaused = false
    @State private var score = 0
    
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
                
                Text("\(self.score)")
                    .position(x: geo.size.width - 100, y: geo.size.height / 10)
                    .foregroundColor(.white)
                
                self.isPaused ? Button("Restart") {
                    self.resume()
                    
                }
                .foregroundColor(.white)
                .font(.title)
                : nil
                
                Ceiling()
                .position(self.ceilingPosition)
                .onReceive(self.timer) {_ in
                    self.ceilingMove()
                    }
                
                Floor()
                .position(self.floorPosition)
                .onReceive(self.timer) {_ in
                    self.floorMove()
                    }
                
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
                .onReceive(self.timer) {_ in
                    self.collision()
                    self.score += 1
                }
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
                 self.obstPosition.y = CGFloat.random(in: 0...500)
            }
        }
        }
    
    func ceilingMove() {
        if self.ceilingPosition.x >= 0
        {
            withAnimation{
                self.ceilingPosition.x = 0
            }
        }
    }
    
    func floorMove() {
        if self.floorPosition.x >= 0
        {
            withAnimation{
                self.floorPosition.x = 0
            }
        }
    }
    
    func pause() {
        self.timer.upstream.connect().cancel()
    }
    
    func resume() {
        self.timer = Timer.publish(every: 0.08, on: .main, in: .common).autoconnect()
        
        self.obstPosition.x = 1000                      // Move obstacle to starting position
        self.wbcPosition = CGPoint(x: 100, y: 100)      // WBC to starting position
        self.isPaused = false                           // Remove restart button after restarting
        self.score = 0
    }
    
    func collision() {
        if abs(wbcPosition.y - obstPosition.y) < (30 + 30) && abs(wbcPosition.x - obstPosition.x) < (30 + 30) {
            self.pause()
            self.isPaused = true
        }
        if abs(wbcPosition.x - ceilingPosition.x) < (25 + 1000) && abs(wbcPosition.y - ceilingPosition.y) < (25 + 2) {
            self.pause()
            self.isPaused = true
        }
        if abs(wbcPosition.x - floorPosition.x) < (25 + 1000) && abs(wbcPosition.y - floorPosition.y) < (25 + 5) {
            self.pause()
            self.isPaused = true
        }
    }
}
